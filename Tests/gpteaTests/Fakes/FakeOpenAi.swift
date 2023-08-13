import Foundation
import OpenAI

//public class FakeOpenAI: OpenAIProtocol {
//
//    public init() {
//        // Initialization code if needed
//    }
//
//    public func completions(query: CompletionsQuery, completion: @escaping (Result<CompletionsResult, Error>) -> Void) {
//        // Fake response
//        let result = CompletionsResult(/* your properties here */)
//        completion(.success(result))
//    }
//
//    public func completionsStream(query: CompletionsQuery, onResult: @escaping (Result<CompletionsResult, Error>) -> Void, completion: ((Error?) -> Void)?) {
//        // Fake response
//        let result = CompletionsResult(/* your properties here */)
//        onResult(.success(result))
//        completion?(nil)
//    }
//
//    public func images(query: ImagesQuery, completion: @escaping (Result<ImagesResult, Error>) -> Void) {
//        // Fake response
//        let result = ImagesResult(/* your properties here */)
//        completion(.success(result))
//    }
//
//    public func embeddings(query: EmbeddingsQuery, completion: @escaping (Result<EmbeddingsResult, Error>) -> Void) {
//        // Fake response
//        let result = EmbeddingsResult(/* your properties here */)
//        completion(.success(result))
//    }
//
//    public func chats(query: ChatQuery, completion: @escaping (Result<ChatResult, Error>) -> Void) {
//        // Fake response
//        let result = ChatResult(/* your properties here */)
//        completion(.success(result))
//    }
//
//    public func chatsStream(query: ChatQuery, onResult: @escaping (Result<ChatStreamResult, Error>) -> Void, completion: ((Error?) -> Void)?) {
//        // Fake response
//        let result = ChatStreamResult(/* your properties here */)
//        onResult(.success(result))
//        completion?(nil)
//    }
//
//    public func edits(query: EditsQuery, completion: @escaping (Result<EditsResult, Error>) -> Void) {
//        // Fake response
//        let result = EditsResult(/* your properties here */)
//        completion(.success(result))
//    }
//
//    public func model(query: ModelQuery, completion: @escaping (Result<ModelResult, Error>) -> Void) {
//        // Fake response
//        let result = ModelResult(/* your properties here */)
//        completion(.success(result))
//    }
//
//    public func models(completion: @escaping (Result<ModelsResult, Error>) -> Void) {
//        // Fake response
//        let result = ModelsResult(/* your properties here */)
//        completion(.success(result))
//    }
//
//    public func moderations(query: ModerationsQuery, completion: @escaping (Result<ModerationsResult, Error>) -> Void) {
//        // Fake response
//        let result = ModerationsResult(/* your properties here */)
//        completion(.success(result))
//    }
//
//    public func audioTranscriptions(query: AudioTranscriptionQuery, completion: @escaping (Result<AudioTranscriptionResult, Error>) -> Void) {
//        // Fake response
//        let result = AudioTranscriptionResult(/* your properties here */)
//        completion(.success(result))
//    }
//
//    public func audioTranslations(query: AudioTranslationQuery, completion: @escaping (Result<AudioTranslationResult, Error>) -> Void) {
//        // Fake response
//        let result = AudioTranslationResult(/* your properties here */)
//        completion(.success(result))
//    }
//}
