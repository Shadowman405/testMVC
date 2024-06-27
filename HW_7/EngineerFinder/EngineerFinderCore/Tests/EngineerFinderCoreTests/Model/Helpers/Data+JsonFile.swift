import Foundation

extension Data {
    init(from jsonFile: JsonFile) throws {
        guard let url = Bundle.module.url(
            forResource: jsonFile.name,
            withExtension: jsonFile.extension
        ) else {
            throw URLError(.fileDoesNotExist)
        }

        try self.init(contentsOf: url)
    }
}
