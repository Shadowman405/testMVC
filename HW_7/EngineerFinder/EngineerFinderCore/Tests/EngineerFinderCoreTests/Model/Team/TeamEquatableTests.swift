@testable import EngineerFinderCore
import XCTest

final class TeamEquatableTestCases: XCTestCase {
    func test_equatable_withTheSameNameOnly_returnsFalse() {
        // Given
        let commonTeamName = "AOL"

        let firstTeam = Team(
            name: commonTeamName,
            employees: [Employee(fullName: "Chris Madison", email: "chrismadison@aol.com")]
        )
        let secondTeam = Team(
            name: commonTeamName,
            employees: [Employee(fullName: "David Wasserman", email: "dwasserman@aol.com")],
            subteams: [firstTeam]
        )

        // When, Then
        XCTAssertNotEqual(firstTeam, secondTeam)
    }

    func test_equatable_withTheSameEmployeesOnly_returnsFalse() {
        // Given
        let commonEmployees = [
            Employee(fullName: "Chris Madison", email: "chrismadison@aol.com"),
            Employee(fullName: "David Wasserman", email: "dwasserman@aol.com"),
        ]

        let firstTeam = Team(name: "AOL", employees: commonEmployees)
        let secondTeam = Team(name: "Google", employees: commonEmployees)

        // When, Then
        XCTAssertNotEqual(firstTeam, secondTeam)
    }

    func test_equatable_withTheSameSubteamsOnly_returnsFalse() {
        // Given
        let commonSubTeams = [
            Team(name: "iOS", employees: [
                Employee(
                    fullName: "Chris Madison",
                    email: "chrismadison@aol.com"
                )]),
            Team(name: "iOS", employees: [
                Employee(
                    fullName: "David Wasserman",
                    email: "dwasserman@aol.com"
                )]),
        ]

        let firstTeam = Team(
            name: "AOL",
            employees: [Employee(fullName: "Chris Webber", email: "cweb@aol.com")],
            subteams: commonSubTeams
        )
        let secondTeam = Team(
            name: "Google",
            employees: [Employee(fullName: "Luke Throne", email: "lllto@gmail.com")],
            subteams: commonSubTeams
        )

        // When, Then
        XCTAssertNotEqual(firstTeam, secondTeam)
    }

    func test_equatable_withTheSameNameAndEmployees_returnsFalse() {
        // Given
        let commonTeamName = "AOL"
        let commonEmployees = [
            Employee(fullName: "Chris Madison", email: "chrismadison@aol.com"),
            Employee(fullName: "Chris Webber", email: "cweb@aol.com"),
        ]

        let firstTeam = Team(
            name: commonTeamName,
            employees: commonEmployees
        )
        let secondTeam = Team(
            name: commonTeamName,
            employees: commonEmployees,
            subteams: [firstTeam]
        )

        // When, Then
        XCTAssertNotEqual(firstTeam, secondTeam)
    }

    func test_equatable_withTheSameNameAndSubteams_returnsFalse() {
        // Given
        let commonTeamName = "Google"
        let commonSubTeams = [
            Team(name: "iOS", employees: [
                Employee(
                    fullName: "Anton Hook",
                    email: "ahook@gmail.com"
                )]),
            Team(name: "iOS", employees: [
                Employee(
                    fullName: "Klay Fort",
                    email: "fotttt@gmail.com"
                )]),
        ]

        let firstTeam = Team(
            name: commonTeamName,
            employees: [Employee(fullName: "Don Foster", email: "dfrost@gmail.com")],
            subteams: commonSubTeams
        )
        let secondTeam = Team(
            name: commonTeamName,
            employees: [Employee(fullName: "Jhzhu Lei", email: "zheshen@gmail.com")],
            subteams: commonSubTeams
        )

        // When, Then
        XCTAssertNotEqual(firstTeam, secondTeam)
    }

    func test_equatable_withTheSameEmployeeAndSubteams_returnsFalse() {
        // Given
        let commonEmployees = [
            Employee(fullName: "Andrew Nordi", email: "aNord@aol.com"),
            Employee(fullName: "Bob Neck", email: "neckless@aol.com"),
        ]
        let commonSubTeams = [
            Team(name: "iOS", employees: [
                Employee(
                    fullName: "Walles Mol",
                    email: "wlm@gmail.com"
                )]),
            Team(name: "iOS", employees: [
                Employee(
                    fullName: "Kate Wit",
                    email: "kitty99@gmail.com"
                )]),
        ]

        let firstTeam = Team(name: "AOL", employees: commonEmployees, subteams: commonSubTeams)
        let secondTeam = Team(name: "Apple", employees: commonEmployees, subteams: commonSubTeams)

        // When, Then
        XCTAssertNotEqual(firstTeam, secondTeam)
    }

    func test_equatable_withTheSameAllFields_returnsTrue() {
        // Given
        let commonTeamName = "AOL"
        let commonEmployees = [
            Employee(fullName: "Andrew Nordi", email: "aNord@aol.com"),
            Employee(fullName: "Bob Neck", email: "neckless@aol.com"),
        ]
        let commonSubTeams = [
            Team(name: "iOS", employees: [
                Employee(
                    fullName: "Bob Frog",
                    email: "froggy@aol.com"
                )]),
            Team(name: "iOS", employees: [
                Employee(
                    fullName: "Dio Petras",
                    email: "dpetr@aol.com"
                )]),
        ]

        let firstTeam = Team(
            name: commonTeamName,
            employees: commonEmployees,
            subteams: commonSubTeams
        )
        let secondTeam = Team(
            name: commonTeamName,
            employees: commonEmployees,
            subteams: commonSubTeams
        )

        // When, Then
        XCTAssertEqual(firstTeam, secondTeam)
    }

    func test_equatable_withEmptyProperties_returnsTrue() {
        // Given
        let firstTeam = Team(name: "", employees: [], subteams: [])
        let secondTeam = Team(name: "", employees: [], subteams: [])

        // When, Then
        XCTAssertEqual(firstTeam, secondTeam)
    }
}
