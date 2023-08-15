import Foundation
import OpenAI

protocol MarkdownRepresentable {
    var asMarkdown: String { get }
}

extension GptModel where Self: MarkdownRepresentable {
    var asText: String { asMarkdown }
}

struct BulletedList: GptModel {
    struct BulletedItem: GptModel {
        let text: String
        // TODO: add subitems

        static func makeEmpty() -> BulletedList.BulletedItem {
            return BulletedItem(text: "")
        }

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

    var asText: String {
        "\(line1)\n\(line2)\n\(line3)"
    }

    static func makeEmpty() -> Haiku {
        return Haiku(line1: "", line2: "", line3: "")
    }
}

struct SimpleText: GptModel {
    let text: String

    var asText: String {
        text
    }

    static func makeEmpty() -> SimpleText {
        return SimpleText(text: "")
    }
}

struct QuestionList: GptModel {
    let questions: [String]

    var asText: String {
        questions.joined(separator: "\n")
    }

    static func makeEmpty() -> QuestionList {
        return QuestionList(questions: [""])
    }
}

struct ActionItems: GptModel {
    let items: [String]

    var asText: String {
        items.joined(separator: "\n")
    }

    static func makeEmpty() -> ActionItems {
        return ActionItems(items: [""])
    }
}

struct RhymingCouplet: GptModel {
    let line1: String
    let line2: String

    var asText: String {
        "\(line1)\n\(line2)"
    }

    static func makeEmpty() -> RhymingCouplet {
        return RhymingCouplet(line1: "", line2: "")
    }
}

struct Limerick: GptModel {
    let line1: String
    let line2: String
    let line3: String
    let line4: String
    let line5: String

    var asText: String {
        "\(line1)\n\(line2)\n\(line3)\n\(line4)\n\(line5)"
    }

    static func makeEmpty() -> Limerick {
        return Limerick(line1: "", line2: "", line3: "", line4: "", line5: "")
    }
}

struct Acrostic: GptModel {
    let lines: [String]

    var asText: String {
        lines.joined(separator: "\n")
    }

    static func makeEmpty() -> Acrostic {
        return Acrostic(lines: [""])
    }
}
