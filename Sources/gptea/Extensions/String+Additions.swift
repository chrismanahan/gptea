import Foundation
import OpenAI

extension String {
    func asChat(_ role: Chat.Role) -> Chat {
        return Chat(role: role, content: self)
    }
}
