public struct gptea {
    public private(set) var text = "Hello, World!"

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
    func makeOutputModel(from jsonString: String) -> Output?

    /// Optional - Implement this method to aggregate multiple outputs (which results from having multiple `transformationPrompts`) into a single model.
    /// - Note:`outputs` need to be of type `Output`
    func aggregationTransformer(_ outputs: [GptModel]) -> GptModel?
}

public protocol ContextProvider: SystemPromptable {
    var contextPrompt: String { get }
    func provide() async -> ModelType
}
