import Foundation

// MARK: - AllEmployees
public struct AllEmployees: Codable {
    let team: String
    var people: [Employee]
    let subteams: [Subteam]?
}

// MARK: - Employee
public struct Employee: Codable {
    let fullName, email: String
    let reports: [Report]?

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case email, reports
    }
}

// MARK: - Report
public struct Report: Codable {
    let fullName, email: String

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case email
    }
}

// MARK: - Subteam
public struct Subteam: Codable {
    let team: String
    let people: [Report]
}
