import Foundation
import OpenAI

protocol MarkdownRepresentable {
    var asMarkdown: String { get }
}

extension GptModel where Self: MarkdownRepresentable {
    var asText: String { asMarkdown }
}

struct BulletedList: GptModel {
    static var systemDescription: String {
        "A BulletedList is a list of easily digestible chunks of information that makes it easier to understand the input. When creating a BulletedList, elaborate and expand on the original output."
    }

    struct BulletedItem: GptModel {
        let text: String
        // TODO: add subitems

        static func makeEmpty() -> BulletedList.BulletedItem {
            return BulletedItem(text: "")
        }

        static var systemDescription: String { "" }

        var asText: String { text }
    }

    let items: [BulletedItem]

    static func makeEmpty() -> BulletedList {
        return BulletedList(items: [BulletedItem.makeEmpty()])
    }

    var asText: String {
        items.map { "- \($0.text)"}.joined(separator: "\n")
    }
}

struct Haiku: GptModel {
    let line1: String
    let line2: String
    let line3: String

    static var systemDescription: String {
        "A Haiku is a form of traditional Japanese poetry that consists of three lines. The first and third lines have 5 syllables each, and the second line has 7 syllables."
    }

    var asText: String {
        "\(line1)\n\(line2)\n\(line3)"
    }

    static func makeEmpty() -> Haiku {
        return Haiku(line1: "", line2: "", line3: "")
    }
}

struct Limerick: GptModel {
    let line1: String
    let line2: String
    let line3: String
    let line4: String
    let line5: String

    static var systemDescription: String {
        "A Limerick is a humorous verse form of five lines with AABBA rhyme scheme."
    }

    var asText: String {
        "\(line1)\n\(line2)\n\(line3)\n\(line4)\n\(line5)"
    }

    static func makeEmpty() -> Limerick {
        return Limerick(line1: "", line2: "", line3: "", line4: "", line5: "")
    }
}

struct Acrostic: GptModel {
    let lines: [String]

    static var systemDescription: String {
        "An Acrostic is a poem or other form of writing in which the first letter, syllable, or word of each line spells out a word or message."
    }

    var asText: String {
        lines.joined(separator: "\n")
    }

    static func makeEmpty() -> Acrostic {
        return Acrostic(lines: [""])
    }
}
