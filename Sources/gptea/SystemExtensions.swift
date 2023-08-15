import Foundation
import OpenAI

// MARK: - GptModel

extension GptModel {
    static func getClassName() -> String {
        return String(describing: type(of: self)).replacingOccurrences(of: ".Type", with: "")
    }
}

// MARK: - SystemPromptable

public extension SystemPromptable {
    func getSystemPrompt() -> String {
        return """
            [Task]\(outputDescription)
            Use this empty JSON blob to generate instances of \(ModelType.getClassName()):
            \(ModelType.asEmptyJson())
            [/Task]
        """
    }
}

// MARK: - Transformations

public extension GptTransformationConfig {
    func makeOutputModel(from jsonString: String) -> Output? {
        return Output.fromJsonString(jsonString)
    }

    func aggregationTransformer(_ outputs: [GptModel]) -> GptModel? {
        return nil
    }

    func preprocess<I: GptModel, O: GptModel>(input: I) async -> O where I == Input, O == ProcessedInput {
        return input as! O
    }

    func transformationChats(input: ProcessedInput) -> [Chat] {
        return transformationPrompts(input: input).map {
            "[Task]\($0). [OutputFormat]:\(Output.getClassName()) as JSON.[/OutputFormat][/Task]".asChat(.user)
        }
    }
}

// MARK: - ContextProvider

extension ContextProvider {
    func getSystemPrompt() -> String {
        return """
        \(contextSystemPrompt).\n
        \(provide().asJson!)
        """
    }
}
