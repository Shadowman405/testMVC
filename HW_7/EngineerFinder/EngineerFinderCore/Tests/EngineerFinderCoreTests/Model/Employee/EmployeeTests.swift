@testable import EngineerFinderCore
import XCTest

final class EmployeeTestCases: XCTestCase {
    func test_init_withEmptyValues_createsInstanceWithEmptyPropertyValues() {
        // Given
        let expectedFullName = ""
        let expectedEmail = ""
        let expectedReports = [Employee]()

        // When
        let createdEmployee = Employee(
            fullName: expectedFullName,
            email: expectedEmail,
            reports: expectedReports
        )

        // Then
        XCTAssertEqual(createdEmployee.fullName, expectedFullName)
        XCTAssertEqual(createdEmployee.email, expectedEmail)
        XCTAssertEqual(createdEmployee.reports, expectedReports)
    }

    func test_init_withValues_createsInstanceWithTheSamePropertyValues() {
        // Given
        let expectedFullName = "Alex Bowman"
        let expectedEmail = "alexbowman@apple.com"
        let expectedReports = [Employee(
            fullName: "Chris Madison",
            email: "chrismadison@aol.com",
            reports: []
        )]

        // When
        let createdEmployee = Employee(
            fullName: expectedFullName,
            email: expectedEmail,
            reports: expectedReports
        )

        // Then
        XCTAssertEqual(createdEmployee.fullName, expectedFullName)
        XCTAssertEqual(createdEmployee.email, expectedEmail)
        XCTAssertEqual(createdEmployee.reports, expectedReports)
    }
}
