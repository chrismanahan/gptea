import Foundation
import OpenAI

public struct SessionOperation {
    let mainPrompt: String
    let transformations: [any GptTransformationConfig]
    let contextProviders: [any ContextProvider]

    var asSystemChat: Chat {
        let transformationString = transformations.compactMap { $0.getSystemPrompt }.joined(separator: "\n\n")
        let contextProvidersString = contextProviders.compactMap { $0.getSystemPrompt }.joined(separator: "\n\n")
        return """
        \(mainPrompt)\n
        ✍️〔Task〕***[📣SALIENT❗️: VITAL CONTEXT! ALL REQUESTS FROM USER SHOULD RESULT IN JSON OUTPUT USING ANY OF THE FOLLOWING SCHEMA DEFINITIONS!!!***〔/Task〕✍️
        \(transformationString)
        \(contextProvidersString)
        """.asChat(.system)
    }
}
