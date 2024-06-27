@testable import EngineerFinderCore
import XCTest

final class TeamDecodableTests: XCTestCase {
    func test_withEmptyNameFieldJson_createsInstanceWithCorrectPropertyValues() throws {
        // Given
        let encodedTeamData = try Data(from: JsonFile.withEmptyNameField)
        let expectedResult = Team(
            name: "",
            employees: [Employee(fullName: "Bob Fett", email: "fetter1999@aol.com")],
            subteams: [
                Team(
                    name: "iOS",
                    employees: [Employee(fullName: "Kate Shawn", email: "katesssss@yahoo.net")]
                ),
            ]
        )

        // When
        let decodedTeam = try JSONDecoder().decode(Team.self, from: encodedTeamData)

        // Then
        XCTAssertEqual(decodedTeam, expectedResult)
    }

    func test_withEmptyPeopleFieldJson_createsInstanceWithCorrectPropertyValues() throws {
        // Given
        let encodedTeamData = try Data(from: JsonFile.withEmptyPeopleField)
        let expectedResult = Team(
            name: "Engineering (Mobile)",
            employees: [],
            subteams: [
                Team(
                    name: "iOS",
                    employees: [Employee(fullName: "Kate Shawn", email: "katesssss@yahoo.net")]
                ),
            ]
        )

        // When
        let decodedTeam = try JSONDecoder().decode(Team.self, from: encodedTeamData)

        // Then
        XCTAssertEqual(decodedTeam, expectedResult)
    }

    func test_withEmptySubteamsFieldJson_createsInstanceWithCorrectPropertyValues() throws {
        // Given
        let encodedTeamData = try Data(from: JsonFile.withEmptySubteamsField)
        let expectedResult = Team(
            name: "Engineering (Mobile)",
            employees: [Employee(fullName: "Bob Fett", email: "fetter1999@aol.com")],
            subteams: []
        )

        // When
        let decodedTeam = try JSONDecoder().decode(Team.self, from: encodedTeamData)

        // Then
        XCTAssertEqual(decodedTeam, expectedResult)
    }

    func test_withoutSubteamsFieldJson_createsInstanceWithCorrectPropertyValues() throws {
        // Given
        let encodedTeamData = try Data(from: JsonFile.withoutSubteamsFields)
        let expectedResult = Team(
            name: "Engineering (Mobile)",
            employees: [Employee(fullName: "Bob Fett", email: "fetter1999@aol.com")],
            subteams: []
        )

        // When
        let decodedTeam = try JSONDecoder().decode(Team.self, from: encodedTeamData)

        // Then
        XCTAssertEqual(decodedTeam, expectedResult)
    }

    func test_withValidAllFieldsJson_createsInstanceWithCorrectPropertyValues() throws {
        // Given
        let encodedTeamData = try Data(from: JsonFile.withValidAllFields)
        let expectedResult = Team(
            name: "Engineering (Mobile)",
            employees: [Employee(fullName: "Bob Fett", email: "fetter1999@aol.com")],
            subteams: [
                Team(
                    name: "iOS",
                    employees: [Employee(fullName: "Kate Shawn", email: "katesssss@yahoo.net")]
                ),
            ]
        )

        // When
        let decodedTeam = try JSONDecoder().decode(Team.self, from: encodedTeamData)

        // Then
        XCTAssertEqual(decodedTeam, expectedResult)
    }

    func test_withSubSubteamFieldsJson_createsInstanceWithCorrectPropertyValues() throws {
        // Given
        let encodedTeamData = try Data(from: JsonFile.withSubSubteamsFields)
        let subSubteam = Team(name: "iOS Three", employees: [
            Employee(
                fullName: "Todd Howard",
                email: "buySkyrimOneMoreTime@bethesda.net"
            )], subteams: [])
        let subteam = Team(name: "iOS Two", employees: [
            Employee(
                fullName: "Kate Shawn",
                email: "katesssss@yahoo.net"
            )], subteams: [subSubteam])
        let expectedResult = Team(
            name: "iOS One",
            employees: [Employee(fullName: "Bob Fett", email: "fetter1999@aol.com")],
            subteams: [subteam]
        )

        // When
        let decodedTeam = try JSONDecoder().decode(Team.self, from: encodedTeamData)

        // Then
        XCTAssertEqual(decodedTeam, expectedResult)
    }

    func test_withEmptyAllFieldsJson_createsInstanceWithCorrectPropertyValues() throws {
        // Given
        let encodedTeamData = try Data(from: JsonFile.withEmptyAllFields)
        let expectedResult = Team(name: "", employees: [], subteams: [])

        // When
        let decodedTeam = try JSONDecoder().decode(Team.self, from: encodedTeamData)

        // Then
        XCTAssertEqual(decodedTeam, expectedResult)
    }

    func test_withBrokenDataJson_throwsAnError() throws {
        // Given
        let brokenEncodedTeamData = try Data(from: JsonFile.brokenData)

        // When, Then
        XCTAssertThrowsError(
            try JSONDecoder().decode(Team.self, from: brokenEncodedTeamData)
        )
    }
}

// MARK: - JSON files related to TeamAndDecodableTestCases

private extension JsonFile {
    static let brokenData = JsonFile(name: "Team_broken_data")
    static let withEmptyAllFields = JsonFile(name: "Team_empty_all_fields")
    static let withEmptyNameField = JsonFile(name: "Team_empty_name_field")
    static let withEmptyPeopleField = JsonFile(name: "Team_empty_people_field")
    static let withEmptySubteamsField = JsonFile(name: "Team_empty_subteam_field")
    static let withoutSubteamsFields = JsonFile(name: "Team_without_subteam_fields")
    static let withValidAllFields = JsonFile(name: "Team_valid_all_fields")
    static let withSubSubteamsFields = JsonFile(name: "Team_with_sub_subteam")
}
