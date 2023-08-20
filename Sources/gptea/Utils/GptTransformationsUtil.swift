//
//  File.swift
//  
//
//  Created by Chris Manahan on 8/20/23.
//

import Foundation

struct GptTransformationsUtil {
    static func mapDedupedSystemPrompts(_ transformations: [GptTransformationType]) -> [String] {
        return Array(Set(transformations
            .compactMap { $0.getSystemPrompt() }))
    }
}
