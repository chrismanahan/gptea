import Foundation
import OpenAI

public extension String {
    func asChat(_ role: Chat.Role) -> Chat {
        return Chat(role: role, content: self)
    }
}

extension String: GptModel {
    public static func makeEmpty() -> String { "" }

    public var asText: String { self }
}
