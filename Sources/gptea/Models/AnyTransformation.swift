import Foundation
import OpenAI

public class AnyTransformation {
    private let _transformationPrompts: (GptModel) -> [String]
    private let _transformationChats: (GptModel) -> [Chat]
    private let _preprocess: (GptModel) async -> GptModel
    private let _aggTransformer: ([GptModel]) -> GptModel?

    public init<T: GptTransformationConfig>(_ transformation: T) {
        _transformationPrompts = { input in
            guard let input = input as? T.Input else { return [] }
            return transformation.transformationPrompts(input: input)
        }

        _aggTransformer = { (models: [GptModel]) in
            return transformation
                .aggregationTransformer(models)
        }

        _preprocess = { input in
            return await transformation.preprocess(input: input)
        }
        _transformationChats = { input in
            guard let input = input as? T.Input else { return [] }
            return transformation.transformationChats(input: input)
        }
    }

    func transformationPrompts(input: GptModel) -> [String] {
        return _transformationPrompts(input)
    }

    func preprocess(input: GptModel) async -> GptModel {
        return await _preprocess(input)
    }

    func aggregationTransformer(_ outputs: [GptModel]) -> GptModel? {
        return _aggTransformer(outputs)
    }

    func transformationChats(input: GptModel) -> [Chat] {
        return _transformationChats(input)
    }
}
