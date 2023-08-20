public struct gptea {
    public init() {
    }
}

public protocol GPTSession {
    func run(_ sessionOperation: SessionOperation, input: GptModel) async -> [GptModel]
}

public protocol GptModel: Codable {
    static func makeEmpty() -> Self
    var asText: String { get }
}

public protocol SystemPromptable {
    associatedtype ModelType: GptModel
    /// Describes the `Output` model. Provide details about what each key is for. Its recommended to include
    /// the name of your model's class.
    var outputDescription: String { get }
}

public protocol GptTransformationConfig: SystemPromptable where ModelType == Output {
    associatedtype Input: GptModel
    associatedtype Output: GptModel

    func transformationPrompts<T: GptModel>(input: T) -> [String] where T == Input

    /// Optional - Implement this method to aggregate multiple outputs (which results from having multiple `transformationPrompts`) into a single model.
    /// - Note:`outputs` need to be of type `Output`
    func aggregationTransformer(_ outputs: [GptModel]) -> GptModel?
}

public protocol PreProcessableTransformationconfig: GptTransformationConfig {
    associatedtype ProcessedInput: GptModel

    func preProcess<I: GptModel, O: GptModel>(input: I) async -> O where I == Input, O == ProcessedInput
}

public protocol PostProcessableTransformationconfig: GptTransformationConfig {
    associatedtype ProcessedOutput: GptModel

    func postProcess<I: GptModel, O: GptModel>(input: I) async -> O where I == Output, O == ProcessedOutput
}

public enum GptTransformationType {
    case standard(any GptTransformationConfig)
    case preProcess(any PreProcessableTransformationconfig)
    case postProcess(any PostProcessableTransformationconfig)
}

public protocol ContextProvider {
    associatedtype ProvidedType: GptModel
    var contextSystemPrompt: String { get }
    func provide() -> ProvidedType
}
