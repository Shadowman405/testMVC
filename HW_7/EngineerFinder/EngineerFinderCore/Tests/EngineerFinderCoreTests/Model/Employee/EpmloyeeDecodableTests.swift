@testable import EngineerFinderCore
import XCTest

final class EmployeeAndDecodableTestCases: XCTestCase {
    func test_decodable_withEmptyFullNameJson_createsInstanceWithExpectedPropertyValues() throws {
        // Given
        let encodedEmployeeData = try Data(from: JsonFile.withEmptyFullName)
        let expectedResult = Employee(fullName: "", email: "alexbowman@apple.com", reports: [
            Employee(fullName: "Barry Johnson", email: "barryjohnson@gmail.com"),
        ])

        // When
        let decodedEmployee = try JSONDecoder().decode(Employee.self, from: encodedEmployeeData)

        // Then
        XCTAssertEqual(decodedEmployee.fullName, expectedResult.fullName)
        XCTAssertEqual(decodedEmployee.email, expectedResult.email)
        XCTAssertEqual(decodedEmployee.reports, expectedResult.reports)
    }

    func test_decodable_withEmptyEmailJson_createsInstanceWithExpectedPropertyValues() throws {
        // Given
        let encodedEmployeeData = try Data(from: JsonFile.withEmptyEmail)
        let expectedResult = Employee(fullName: "Alex Bowman", email: "", reports: [
            Employee(fullName: "Barry Johnson", email: "barryjohnson@gmail.com"),
        ])

        // When
        let decodedEmployee = try JSONDecoder().decode(Employee.self, from: encodedEmployeeData)

        // Then
        XCTAssertEqual(decodedEmployee.fullName, expectedResult.fullName)
        XCTAssertEqual(decodedEmployee.email, expectedResult.email)
        XCTAssertEqual(decodedEmployee.reports, expectedResult.reports)
    }

    func test_decodable_withEmptyReportsJson_createsInstanceWithExpectedPropertyValues() throws {
        // Given
        let encodedEmployeeData = try Data(from: JsonFile.withEmptyReports)
        let expectedResult = Employee(
            fullName: "Alex Bowman",
            email: "alexbowman@apple.com",
            reports: []
        )

        // When
        let decodedEmployee = try JSONDecoder().decode(Employee.self, from: encodedEmployeeData)

        // Then
        XCTAssertEqual(decodedEmployee.fullName, expectedResult.fullName)
        XCTAssertEqual(decodedEmployee.email, expectedResult.email)
        XCTAssertEqual(decodedEmployee.reports, expectedResult.reports)
    }

    func test_decodable_withoutReportsJson_createsInstanceWithExpectedPropertyValues() throws {
        // Given
        let encodedEmployeeData = try Data(from: JsonFile.withoutReports)
        let expectedResult = Employee(
            fullName: "Alex Bowman",
            email: "alexbowman@apple.com",
            reports: []
        )

        // When
        let decodedEmployee = try JSONDecoder().decode(Employee.self, from: encodedEmployeeData)

        // Then
        XCTAssertEqual(decodedEmployee.fullName, expectedResult.fullName)
        XCTAssertEqual(decodedEmployee.email, expectedResult.email)
        XCTAssertEqual(decodedEmployee.reports, expectedResult.reports)
    }

    func test_decodable_withAllFilledFieldsJson_createsInstanceWithExpectedPropertyValues() throws {
        // Given
        let encodedEmployeeData = try Data(from: JsonFile.withAllFilledFields)
        let expectedResult = Employee(
            fullName: "Alex Bowman",
            email: "alexbowman@apple.com",
            reports: [Employee(fullName: "Barry Johnson", email: "barryjohnson@gmail.com")]
        )

        // When
        let decodedEmployee = try JSONDecoder().decode(Employee.self, from: encodedEmployeeData)

        // Then
        XCTAssertEqual(decodedEmployee.fullName, expectedResult.fullName)
        XCTAssertEqual(decodedEmployee.email, expectedResult.email)
        XCTAssertEqual(decodedEmployee.reports, expectedResult.reports)
    }

    func test_decodable_withEmptyFieldsJson_createsInstanceWithExpectedPropertyValues() throws {
        // Given
        let encodedEmployeeData = try Data(from: JsonFile.withEmptyFields)
        let expectedResult = Employee(fullName: "", email: "", reports: [])

        // When
        let decodedEmployee = try JSONDecoder().decode(Employee.self, from: encodedEmployeeData)

        // Then
        XCTAssertEqual(decodedEmployee.fullName, expectedResult.fullName)
        XCTAssertEqual(decodedEmployee.email, expectedResult.email)
        XCTAssertEqual(decodedEmployee.reports, expectedResult.reports)
    }

    func test_decodable_brokenJson_throwsAnError() throws {
        // Given
        let brokenEncodedEmployeeData = try Data(from: JsonFile.brokenData)

        // When, Then
        XCTAssertThrowsError(
            try JSONDecoder().decode(Employee.self, from: brokenEncodedEmployeeData)
        )
    }
}

// MARK: - JSON files related to EmployeeDecodableTests

private extension JsonFile {
    static let brokenData = JsonFile(name: "Employee_broken_data")
    static let withEmptyFields = JsonFile(name: "Employee_with_all_empty_fields")
    static let withAllFilledFields = JsonFile(name: "Employee_with_all_filled_fields")
    static let withEmptyEmail = JsonFile(name: "Employee_with_empty_email")
    static let withEmptyFullName = JsonFile(name: "Employee_with_empty_fullname")
    static let withEmptyReports = JsonFile(name: "Employee_with_empty_reports")
    static let withoutReports = JsonFile(name: "Employee_without_reports")
}
