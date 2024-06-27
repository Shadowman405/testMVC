@testable import EngineerFinderCore
import XCTest

final class EmployeeAndEquatableTestCases: XCTestCase {
    func test_equatable_withTheSameFullNameOnly_notEqual() {
        // Given
        let commonName = "Alex Bowman"

        let firstEmployee = Employee(fullName: commonName, email: "alexbowman@apple.com")
        let secondEmployee = Employee(
            fullName: commonName,
            email: "barryjohnson@gmail.com",
            reports: [firstEmployee]
        )

        // When, Then
        XCTAssertNotEqual(firstEmployee, secondEmployee)
    }

    func test_equatable_withTheSameEmailOnly_notEqual() {
        // Given
        let commonEmail = "alexbowman@apple.com"

        let firstEmployee = Employee(fullName: "Alex Bowman", email: commonEmail)
        let secondEmployee = Employee(
            fullName: "Barry Johnson",
            email: commonEmail,
            reports: [firstEmployee]
        )

        // When, Then
        XCTAssertNotEqual(firstEmployee, secondEmployee)
    }

    func test_equatable_withTheSameReportsOnly_notEqual() {
        // Given
        let commonReports = [Employee(fullName: "A", email: "a@a.a")]

        let firstEmployee = Employee(fullName: "B", email: "b@b.b", reports: commonReports)
        let secondEmployee = Employee(fullName: "C", email: "c@c.c", reports: commonReports)

        // When, Then
        XCTAssertNotEqual(firstEmployee, secondEmployee)
    }

    func test_equatable_withTheSameFullNameAndReports_notEqual() {
        // Given
        let commonName = "Alex Bowman"
        let commonReports = [Employee(fullName: "David Wasserman", email: "dwasserman@yahoo.com")]

        let firstEmployee = Employee(
            fullName: commonName,
            email: "alexbowman@apple.com"
        )
        let secondEmployee = Employee(
            fullName: commonName,
            email: "barryjohnson@gmail.com",
            reports: commonReports
        )

        // When, Then
        XCTAssertNotEqual(firstEmployee, secondEmployee)
    }

    func test_equatable_withTheSameEmailAndReports_notEqual() {
        // Given
        let commonEmail = "alexbowman@apple.com"
        let commonReports = [Employee(fullName: "David Wasserman", email: "dwasserman@yahoo.com")]

        let firstEmployee = Employee(
            fullName: "Alex Bowman",
            email: commonEmail,
            reports: commonReports
        )
        let secondEmployee = Employee(
            fullName: "Barry Johnson",
            email: commonEmail,
            reports: commonReports
        )

        // When, Then
        XCTAssertNotEqual(firstEmployee, secondEmployee)
    }

    func test_equatable_withTheSameFullNameAndEmail_areEqual() {
        // Given
        let commonName = "Alex Bowman"
        let commonEmail = "alexbowman@apple.com"

        let firstEmployee = Employee(fullName: commonName, email: commonEmail)
        let secondEmployee = Employee(
            fullName: commonName,
            email: commonEmail,
            reports: [firstEmployee]
        )

        // When, Then
        XCTAssertEqual(firstEmployee, secondEmployee)
    }

    func test_equatable_withEmptyProperties_areEqual() {
        // Given
        let firstEmployee = Employee(fullName: "", email: "", reports: [])
        let secondEmployee = Employee(fullName: "", email: "", reports: [])

        // When, Then
        XCTAssertEqual(firstEmployee, secondEmployee)
    }
}
