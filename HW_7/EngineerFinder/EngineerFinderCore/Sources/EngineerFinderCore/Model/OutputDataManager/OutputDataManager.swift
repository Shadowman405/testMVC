import Foundation

/// Provides an interface to create the string representation of
/// the list of employees split by company names.
public struct OutputDataManager {
    /// Decodes team data from JSON.
    let decoder: TeamDecoder

    /// Initializes a new instance of the data manager.
    /// - Parameters:
    ///   - decoder: Decodes team data from JSON.
    public init(decoder: TeamDecoder = .init()) {
        self.decoder = decoder
    }

    /// Processes input data passed by user.
    /// - Parameter data: The data provided by the user.
    /// - Returns: A result containing either.
    /// the list of employees split by company name or an error.
    func buildListOfEmployees(from data: Data) -> Result<String, Error> {
        do {
            let teams = try decoder.decodeTeams(from: data)
            let outputString = OutputDataBuilder.buildStringRepresentation(of: teams)
            return .success(outputString)
        } catch {
            return .failure(error)
        }
    }
}
