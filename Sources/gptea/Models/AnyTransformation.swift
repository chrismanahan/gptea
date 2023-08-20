import Foundation
import OpenAI

public class AnyTransformation {
    private let _transformationPrompts: (GptModel) -> [String]
    private let _transformationChats: (GptModel) -> [Chat]
    private let _preprocess: (GptModel) async -> GptModel
    private let _postprocess: (GptModel) async -> GptModel
    private let _aggTransformer: ([GptModel]) -> GptModel?

    // TODO: these initializers are kinda sloppy. having trouble with the Transformation
    //      protocols because of the associatedtypes. Ideally this could be a single initiailizer, or just something thats less copy/paste
    public init<T: GptTransformationConfig>(standardTransformation: T) {
        _transformationPrompts = { input in
            guard let input = input as? T.Input else { return [] }
            return standardTransformation.transformationPrompts(input: input)
        }

        _aggTransformer = { (models: [GptModel]) in
            return standardTransformation
                .aggregationTransformer(models)
        }

        _preprocess = { input in input }
        _postprocess = { output in output }

        _transformationChats = { input in
            guard let input = input as? T.Input else { return [] }
            return standardTransformation.transformationChats(input: input)
        }
    }

    public init<T: PreProcessableTransformationconfig>(preProcessableTransformation: T) {
        _transformationPrompts = { input in
            guard let input = input as? T.Input else { return [] }
            return preProcessableTransformation.transformationPrompts(input: input)
        }

        _aggTransformer = { (models: [GptModel]) in
            return preProcessableTransformation
                .aggregationTransformer(models)
        }

        _preprocess = { input in
            guard let input = input as? T.Input else { return input }
            return await preProcessableTransformation.preProcess(input: input)
        }
        _postprocess = { output in output }

        _transformationChats = { input in
            guard let input = input as? T.ProcessedInput else { return [] }
            return preProcessableTransformation.transformationChats(input: input)
        }
    }

    public init<T: PostProcessableTransformationconfig>(postProcessableTransformation: T) {
        _transformationPrompts = { input in
            guard let input = input as? T.Input else { return [] }
            return postProcessableTransformation.transformationPrompts(input: input)
        }

        _aggTransformer = { (models: [GptModel]) in
            return postProcessableTransformation
                .aggregationTransformer(models)
        }

        _preprocess = { input in input }
        _postprocess = { output in
            guard let output = output as? T.Output else { return output }
            return await postProcessableTransformation.postProcess(input: output)
        }

        _transformationChats = { input in
            guard let input = input as? T.Input else { return [] }
            return postProcessableTransformation.transformationChats(input: input)
        }
    }

    func transformationPrompts(input: GptModel) -> [String] {
        return _transformationPrompts(input)
    }

    func preprocess(input: GptModel) async -> GptModel {
        return await _preprocess(input)
    }

    func postProcess(output: GptModel) async -> GptModel {
        return await _postprocess(output)
    }

    func aggregationTransformer(_ outputs: [GptModel]) -> GptModel? {
        return _aggTransformer(outputs)
    }

    func transformationChats(input: GptModel) -> [Chat] {
        return _transformationChats(input)
    }
}
