import Foundation
import OpenAI

public extension String {
    func asChat(_ role: Chat.Role) -> Chat {
        return Chat(role: role, content: self)
    }
}
