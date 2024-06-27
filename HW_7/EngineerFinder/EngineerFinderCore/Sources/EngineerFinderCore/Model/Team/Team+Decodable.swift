extension Team: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name = "team"
        case employees = "people"
        case subteams
    }

    /// Creates a new `Team` instance by decoding from the given decoder.
    /// Initializer throws an error if decoder can't read and decode data.
    /// - Parameter decoder: The decoder to read data from.
    /// - Note: If there are no subteams values, defaults to the empty array for subteams.
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(String.self, forKey: .name)
        employees = try container.decode([Employee].self, forKey: .employees)
        subteams = (try? container.decode([Team].self, forKey: .subteams)) ?? []
    }
}
