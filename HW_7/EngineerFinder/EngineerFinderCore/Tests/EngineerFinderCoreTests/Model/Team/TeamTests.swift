@testable import EngineerFinderCore
import XCTest

final class TeamTestCases: XCTestCase {
    func test_init_withEmptyValues_createsInstanceWithEmptyPropertyValues() {
        // Given
        let expectedName = ""
        let expectedEmployees = [Employee]()
        let expectedSubteams = [Team]()

        // When
        let createdTeam = Team(
            name: expectedName,
            employees: expectedEmployees,
            subteams: expectedSubteams
        )

        // Then
        XCTAssertEqual(createdTeam.name, expectedName)
        XCTAssertEqual(createdTeam.employees, expectedEmployees)
        XCTAssertEqual(createdTeam.subteams, expectedSubteams)
    }

    func test_init_withValues_createsInstanceWithTheSamePropertyValues() {
        // Given
        let expectedName = "AOL"
        let expectedEmployees = [
            Employee(fullName: "Chris Madison", email: "chrismadison@aol.com"),
            Employee(fullName: "Bob Mans", email: "bobmans@aol.com"),
        ]
        let expectedSubteams = [
            Team(name: "iOS", employees: [
                Employee(
                    fullName: "Chris Todd",
                    email: "ctodd@gmail.com"
                )]),
            Team(name: "Android", employees: [
                Employee(
                    fullName: "Jhon Stone",
                    email: "stoner@yahoo.com"
                )]),
        ]

        // When
        let createdTeam = Team(
            name: expectedName,
            employees: expectedEmployees,
            subteams: expectedSubteams
        )

        // Then
        XCTAssertEqual(createdTeam.name, expectedName)
        XCTAssertEqual(createdTeam.employees, expectedEmployees)
        XCTAssertEqual(createdTeam.subteams, expectedSubteams)
    }
}
