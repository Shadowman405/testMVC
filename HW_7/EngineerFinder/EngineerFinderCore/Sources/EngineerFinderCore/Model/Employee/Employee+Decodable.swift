extension Employee: Decodable {
    private enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case email
        case reports
    }

    /// Creates a new `Employee` instance by decoding from the given decoder.
    /// Initializer throws an error if decoder can't read and decode data.
    /// - Parameter decoder: The decoder to read data from.
    /// - Note: If there are no reports values, defaults to the empty array for reports.
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        fullName = try container.decode(String.self, forKey: .fullName)
        email = try container.decode(String.self, forKey: .email)
        reports = (try? container.decode([Employee].self, forKey: .reports)) ?? []
    }
}
