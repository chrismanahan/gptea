import Foundation
import OpenAI

public extension ChatResult {
    var chatMessage: Chat {
        return choices.first!.message
    }
}
