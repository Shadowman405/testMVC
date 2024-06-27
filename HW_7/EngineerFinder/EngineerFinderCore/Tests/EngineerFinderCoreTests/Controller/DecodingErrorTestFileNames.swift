import Foundation

enum DecodingErrorTestFileNames: String {
    /// The file with missed value.
    case missedValue = "MissedValue"
    /// The file with type mismatch.
    case typeMismatch = "TypeMismatch"
    /// The file with missed key.
    case keyNotFound = "KeyNotFound"

    /// Returns the content of the file.
    var data: Data? {
        try? Data(from: JsonFile(name: rawValue))
    }
}
