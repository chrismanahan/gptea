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

    var outputDescription: String {
        "A BulletedList is a list of easily digestible chunks of information that makes it easier to understand the input. When creating a BulletedList, elaborate and expand on the original output."
    }

    func transformationPrompts(input: String) -> [String] {
        ["[Task]Create a BulletedList of this input: \(input)[/Task]"]
    }
}

struct StringToHaikuTransformation: GptTransformationConfig {
    typealias Input = String
    typealias Output = Haiku
    typealias ModelType = Output

    var outputDescription: String {
        "A Haiku is a form of traditional Japanese poetry that consists of three lines. The first and third lines have 5 syllables each, and the second line has 7 syllables."
    }

    func transformationPrompts(input: String) -> [String] {
        ["[Task]Create a single Haiku using this input: \(input)[/Task]"]
    }
}

struct StringElaborationTransformation: GptTransformationConfig {
    typealias Input = String
    typealias Output = SimpleText
    typealias ModelType = Output

    var outputDescription: String {
        "An Elaboration is the process of developing or presenting a theory, policy, or system in further detail. It is the addition of more detail concerning what has already been said. Be sure to use proper escape characters for newlines."
    }

    func transformationPrompts(input: String) -> [String] {
        ["[Task]Write an Elaboration of this input: \(input)[/Task]"]
    }
}

struct StringToSummaryTransformation: GptTransformationConfig {
    typealias Input = String
    typealias Output = SimpleText
    typealias ModelType = Output

    var outputDescription: String {
        "A Summary is a concise version of the input, highlighting the main points."
    }

    func transformationPrompts(input: String) -> [String] {
        ["[Task]Write a Summary of this input: \(input)[/Task]"]
    }
}

struct StringToQuestionListTransformation: GptTransformationConfig {
    typealias Input = String
    typealias Output = QuestionList
    typealias ModelType = Output

    var outputDescription: String {
        "A QuestionList is a list of questions that are derived from the input."
    }

    func transformationPrompts(input: String) -> [String] {
        ["[Task]Create a list of questions based on this input: \(input)[/Task]"]
    }
}

struct StringToActionItemsTransformation: GptTransformationConfig {
    typealias Input = String
    typealias Output = ActionItems
    typealias ModelType = Output

    var outputDescription: String {
        "ActionItems are a list of tasks or steps derived from the input."
    }

    func transformationPrompts(input: String) -> [String] {
        ["[Task]Create a list of action items based on this input: \(input)[/Task]"]
    }
}

struct StringToRhymingCoupletTransformation: GptTransformationConfig {
    typealias Input = String
    typealias Output = RhymingCouplet
    typealias ModelType = Output

    var outputDescription: String {
        "A RhymingCouplet is a pair of lines of verse that form a unit. They usually have the same meter and rhyme scheme."
    }

    func transformationPrompts(input: String) -> [String] {
        ["[Task]Create a RhymingCouplet using this input: \(input)[/Task]"]
    }
}

struct StringToLimerickTransformation: GptTransformationConfig {
    typealias Input = String
    typealias Output = Limerick
    typealias ModelType = Output

    var outputDescription: String {
        "A Limerick is a humorous verse form of five lines with AABBA rhyme scheme."
    }

    func transformationPrompts(input: String) -> [String] {
        ["[Task]Create a Limerick using this input: \(input)[/Task]"]
    }
}

struct StringToAcrosticTransformation: GptTransformationConfig {
    typealias Input = String
    typealias Output = Acrostic
    typealias ModelType = Output

    var outputDescription: String {
        "An Acrostic is a poem or other form of writing in which the first letter, syllable, or word of each line spells out a word or message."
    }

    func transformationPrompts(input: String) -> [String] {
        ["[Task]Create an Acrostic using this input: \(input)[/Task]"]
    }
}


struct StringFormalizerTransformation: GptTransformationConfig {
    typealias Input = String
    typealias Output = SimpleText
    typealias ModelType = Output

    var outputDescription: String {
        "Formalizing an input means to rewrite it in a formal way."
    }

    func transformationPrompts(input: String) -> [String] {
        ["[Task]Create an Acrostic using this input: \(input)[/Task]"]
    }
}
