import Foundation

/// Decode JSON data to array of `Team` structures.
public struct TeamDecoder {
    /// The JSON decoder instance used for decoding data.
    private let decoder: JSONDecoder

    /// Creates a new instance of decoder.
    /// - Parameter decoder: The JSON decoder that decodes data from JSON.
    public init(decoder: JSONDecoder = .init()) {
        self.decoder = decoder
    }

    /// Decodes data from JSON into an array of `Team` structures.
    ///
    /// - Parameter data: The JSON object to decode.
    /// - Returns: The array of `Team` structres decoded from `data`
    /// , if the decoder can parse the data.
    func decodeTeams(from data: Data) throws -> [Team] {
        try decoder.decode([Team].self, from: data)
    }
}
