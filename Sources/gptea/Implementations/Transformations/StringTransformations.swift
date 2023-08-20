//
//  StringTransformations.swift
//  QuickNotes
//
//  Created by Chris Manahan on 8/3/23.
//

import Foundation

struct StringToBulletedListTransformation: GptTransformationConfig {
    typealias Input = String
    typealias Output = BulletedList
    typealias ModelType = Output

    func transformationPrompts(input: String) -> [String] {
        ["[Task]Create a BulletedList of this input: \(input)[/Task]"]
    }
}

struct StringToHaikuTransformation: GptTransformationConfig {
    typealias Input = String
    typealias Output = Haiku
    typealias ModelType = Output

    func transformationPrompts(input: String) -> [String] {
        ["[Task]Create a single Haiku using this input: \(input)[/Task]"]
    }
}

struct StringToLimerickTransformation: GptTransformationConfig {
    typealias Input = String
    typealias Output = Limerick
    typealias ModelType = Output

    func transformationPrompts(input: String) -> [String] {
        ["[Task]Create a Limerick using this input: \(input)[/Task]"]
    }
}

struct StringToAcrosticTransformation: GptTransformationConfig {
    typealias Input = String
    typealias Output = Acrostic
    typealias ModelType = Output

    func transformationPrompts(input: String) -> [String] {
        ["[Task]Create an Acrostic using this input: \(input)[/Task]"]
    }
}
