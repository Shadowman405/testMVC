@testable import EngineerFinderCore
import XCTest

final class TeamDecoderTestCases: XCTestCase {
    func test_decode_withoutPeopleKey_throwsKeyNotFoundError() throws {
        // Given
        let invalidJsonData = try Data(from: JsonFile.withoutPeopleKey)
        let decoder = TeamDecoder()

        do {
            // When
            _ = try decoder.decodeTeams(from: invalidJsonData)

            // Then
            XCTFail("The decoder should have thrown an error")
        } catch DecodingError.keyNotFound {
            return
        } catch {
            XCTFail("An unexpected type of error has been thrown")
        }
    }

    func test_decode_withInvalidValueType_throwsTypeMismatchError() throws {
        // Given
        let invalidJsonData = try Data(from: JsonFile.withInvalidValueType)
        let decoder = TeamDecoder()

        do {
            // When
            _ = try decoder.decodeTeams(from: invalidJsonData)

            // Then
            XCTFail("The decoder should have thrown an error")
        } catch DecodingError.typeMismatch {
            return
        } catch {
            XCTFail("An unexpected type of error has been thrown")
        }
    }

    func test_decode_withInvalidJsonData_throwsDataCorruptedError() {
        // Given
        let invalidJsonData = Data()
        let decoder = TeamDecoder()

        do {
            // When
            _ = try decoder.decodeTeams(from: invalidJsonData)

            // Then
            XCTFail("The decoder should have thrown an error")
        } catch DecodingError.dataCorrupted {
            return
        } catch {
            XCTFail("An unexpected type of error has been thrown")
        }
    }

    func test_decode_withValidJsonData_returnsDecodedArrayOfTeams() throws {
        // Given
        let encodedTeamsData = try Data(from: JsonFile.withValidTwoTeams)
        let decoder = TeamDecoder()

        let expectedResult = [
            Team(
                name: "Engineering (Back-end)",
                employees: [
                    Employee(
                        fullName: "Alex Bowman",
                        email: "alexbowman@apple.com",
                        reports: [
                            Employee(fullName: "Barry Johnson", email: "barryjohnson@gmail.com"),
                        ]
                    ),
                ]
            ),
            Team(
                name: "Engineering (Mobile)",
                employees: [Employee(fullName: "Chris Madison", email: "chrismadison@aol.com")],
                subteams: [
                    Team(
                        name: "iOS",
                        employees: [Employee(
                            fullName: "David Wasserman",
                            email: "dwasserman@yahoo.com"
                        )]
                    ),
                ]
            ),
        ]

        // When
        let decodedTeams = try decoder.decodeTeams(from: encodedTeamsData)

        // Then
        XCTAssertEqual(decodedTeams, expectedResult)
    }

    func test_decode_withNullInValue_throwsValueNotFoundError() throws {
        // Given
        let invalidJsonData = try Data(from: JsonFile.withNullPeopleValue)
        let decoder = TeamDecoder()

        do {
            // When
            _ = try decoder.decodeTeams(from: invalidJsonData)

            // Then
            XCTFail("The decoder should have thrown an error")
        } catch DecodingError.valueNotFound {
            return
        } catch {
            XCTFail("An unexpected type of error has been thrown")
        }
    }
}

// MARK: - JSON files related to TeamDecoderTestCases

private extension JsonFile {
    static let withValidTwoTeams = JsonFile(name: "Teams_valid_data_with_two_teams")
    static let withoutPeopleKey = JsonFile(name: "Teams_without_people_key")
    static let withInvalidValueType = JsonFile(name: "Teams_with_invalid_value_type")
    static let withNullPeopleValue = JsonFile(name: "Teams_people_value_is_null")
}
