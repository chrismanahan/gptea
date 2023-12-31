import Foundation
import OpenAI

public final class FakeGPTSession: GPTSession {
    var setOutput: GptModel? = nil

    public init() {}

    public func run(_ sessionOperation: SessionOperation, input: GptModel) async -> [GptModel] {
        return [setOutput!]
    }
}

@available(macOS 10.15, *)
public final class GPTSessionImpl: GPTSession {
    let client: OpenAI
    let temperature: Double
    let presencePenalty: Double
    let frequencyPenalty: Double
    let model: Model

    private var runningConversation: [Chat] = []

    public init(temperature: Double, presencePenalty: Double, frequencyPenalty: Double, model: Model, client: OpenAI) {
        self.temperature = temperature
        self.presencePenalty = presencePenalty
        self.frequencyPenalty = frequencyPenalty
        self.model = model
        self.client = client
    }

    public func run(_ sessionOperation: SessionOperation, input: GptModel) async -> [GptModel] {
            let rootConvo = [
                sessionOperation.asSystemChat
            ]
        
            print("Running session")
            print(rootConvo.map { $0.content })

            var currentOutput: [GptModel] = [input]
            var convo = rootConvo

            for transformationType in sessionOperation.transformations {
                let anyTransformation = transformationType.asAnyTransformation
                var transformationOutputs: [GptModel] = []

                for output in currentOutput {
                    print("\n--INPUT--")
                    print(output.asJson ?? output.asText)
                    let processedInput = await anyTransformation.preprocess(input: output)
                    let chats = anyTransformation.transformationChats(input: processedInput)
                    validateMappings(chatCount: chats.count, outputsCount: currentOutput.count)

                    for chat in chats {
                        convo.append(chat)
                        print(chat.content ?? "")

                        var response = await runConvo(convo: convo, transformation: transformationType.transformation)

                        // FIXME: this is super janky and will crash atm if we try to prune too many times.
                        //      originally was pruning for the failing case of too many tokens being sent.
                        //      we really should be validating token count before sending the chat and pruning if
                        //      needed. Failures also occur if invalid JSON is returned (or the response includes
                        //      non-json text before the payload)
                        while response.failed {
                            print("pruning convo and trying again. convo count: \(convo.count)")
                            convo = rootConvo + convo.suffix(convo.count - rootConvo.count - 1)
                            response = await runConvo(convo: convo, transformation: transformationType.transformation)
                        }
                        convo.append(response.chatMessage!)
                        let processedOutput = await anyTransformation.postProcess(output: response.outputModel!)
                        transformationOutputs.append(processedOutput)
                        print("\n---OUTPUT----")
                        print(response.outputModel!.asJson!)
                    }
                }
                if let agg = anyTransformation.aggregationTransformer(transformationOutputs) {
                    currentOutput = [agg]
                } else {
                    currentOutput = transformationOutputs
                }
            }
            if currentOutput.count > 1 {
                print("!!!OUTPUT CONTAINS MORE THAN 1")
            }
            return currentOutput
    }

    private struct ChatResponse {
        var chatMessage: Chat? = nil
        var outputModel: GptModel? = nil
        var failed: Bool = false
    }

    private func runConvo(convo: [Chat], transformation: any GptTransformationConfig) async -> ChatResponse {
        let query = makeChatQuery(convo: convo)
        do {
            print("making chat request")
            let output = try await client.chats(query: query)
            print("response: \(output)")
            if let outputModel = transformation.makeOutputModel(from: output.chatMessage.content!) {
                return ChatResponse(chatMessage: output.chatMessage, outputModel: outputModel)
            } else {
                print("!!! Convo likely too long. Failed to parse chat content: \(output.chatMessage.content)")
                return ChatResponse(failed: true)
            }
        } catch let e {
            print("!!! GPT Client failed: \(e)")
            return ChatResponse(failed: true)
        }
    }

    private func makeChatQuery(convo: [Chat]) -> ChatQuery {
        return ChatQuery(model: self.model, messages: convo, temperature: self.temperature, presencePenalty: self.presencePenalty, frequencyPenalty: self.frequencyPenalty)
    }

    // MARK: - Private

    private func validateMappings(chatCount: Int, outputsCount: Int) {
        guard
            (chatCount == 1 && outputsCount >= 1) ||
            (chatCount >= 1 && outputsCount == 1) ||
            (chatCount == 1 && outputsCount == 1) else {
            assertionFailure("Many to Many chats:outputs not supported")
            return
        }
    }
}
