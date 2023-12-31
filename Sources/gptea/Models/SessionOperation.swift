import Foundation
import OpenAI

public struct SessionOperation {
    public let mainPrompt: String
    public let transformations: [GptTransformationType]
    public let contextProviders: [any ContextProvider]

    public init(mainPrompt: String, transformations: [GptTransformationType], contextProviders: [any ContextProvider] = []) {
        self.mainPrompt = mainPrompt
        self.transformations = transformations
        self.contextProviders = contextProviders
    }

    var asSystemChat: Chat {
        let transformationString = GptTransformationsUtil.mapDedupedSystemPrompts(transformations).joined(separator: "\n\n")
        let contextProvidersString = contextProviders.compactMap { $0.getSystemPrompt() }.joined(separator: "\n\n")
        return """
        \(mainPrompt)\n
        ✍️〔Task〕***[📣SALIENT❗️: VITAL CONTEXT! ALL REQUESTS FROM USER SHOULD RESULT IN JSON OUTPUT USING ANY OF THE FOLLOWING SCHEMA DEFINITIONS!!!***〔/Task〕✍️
        \(transformationString)
        \(contextProvidersString)
        """.asChat(.system)
    }
}
