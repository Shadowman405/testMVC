import Foundation

enum SuccesTestFileNames: String {
    /// Represents an input file for the default team.
    case teamValidAllFields = "Team_valid_all_fields_test"
    /// Represents an input file with  subreports.
    case teamWithSubreports = "Team_with_subreports"
    /// Represents an input file with subteams.
    case teamWithSubteams = "Team_with_subteams"

    /// Returns the content of the file.
    var data: Data? {
        try? Data(from: JsonFile(name: rawValue))
    }
}
