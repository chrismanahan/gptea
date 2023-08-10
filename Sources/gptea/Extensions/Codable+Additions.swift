import Foundation

public extension Decodable {
    static func fromJsonString(_ json: String) -> Self? {
        print("Decoding JSON: \(json)")
        let data = Data(json.utf8)
        let decoder = JSONDecoder()

        do {
            let obj = try decoder.decode(Self.self, from: data)
            return obj
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}

public extension Encodable {
    var asJson: String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        if let jsonData = try? encoder.encode(self),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            return jsonString
        } else {
            print("Error encoding example to JSON.")
            return nil
        }
    }
}

public extension Encodable where Self: GptModel {
    static func asEmptyJson() -> String {
        do {
            let jsonData = try JSONEncoder().encode(Self.makeEmpty())
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            preconditionFailure("error encoding empty instance")
        }
        return "{}"
    }
}
