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

    func transformationChats(input: Input) -> [Chat] {
        return transformationPrompts(input: input).map {
            formattedTransformationPrompts(prompt: $0).asChat(.user)
        }
    }

    func formattedTransformationPrompts(prompt: String) -> String {
        return "[Task]\(prompt). [OutputFormat]:\(Output.getClassName()) as JSON.[/OutputFormat][/Task]"
    }
}

public extension PreProcessableTransformationconfig {
    func transformationChats(input: ProcessedInput) -> [Chat] {
        return transformationPrompts(input: input).map {
            formattedTransformationPrompts(prompt: $0).asChat(.user)
        }
    }
}

extension GptTransformationType {
    var asAnyTransformation: AnyTransformation {
        switch self {
        case .standard(let config):
            return AnyTransformation(standardTransformation: config)
        case .preProcess(let config):
            return AnyTransformation(preProcessableTransformation: config)
        case .postProcess(let config):
            return AnyTransformation(postProcessableTransformation: config)
        }
    }

    var transformation: any GptTransformationConfig {
        switch self {
        case .standard(let config):
            return config
        case .preProcess(let config):
            return config
        case .postProcess(let config):
            return config
        }
    }

    func getSystemPrompt() -> String {
        return transformation.getSystemPrompt()
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
