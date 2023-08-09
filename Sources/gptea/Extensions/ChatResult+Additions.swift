import Foundation
import OpenAI

extension ChatResult {
    var chatMessage: Chat {
        return choices.first!.message
    }
}
