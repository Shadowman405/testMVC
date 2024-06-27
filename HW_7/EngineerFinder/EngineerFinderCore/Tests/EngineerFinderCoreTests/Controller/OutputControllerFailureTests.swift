@testable import EngineerFinderCore
import XCTest

final class OutputControllerFailureTests: XCTestCase {
    private var view = OutputViewMock()
    private var controller = OutputController(
        view: OutputViewMock(),
        dataManager: OutputDataManager()
    )
    private var passedExitCode: Int32?

    override func setUp() {
        passedExitCode = nil
        view = .init()
        controller = .init(view: view, dataManager: OutputDataManager())
        controller.exitHandlerWithExitCode = { [weak self] exitCode in
            self?.passedExitCode = exitCode
        }
    }

    func test_withEmptyInput_returnIncorrectDataError() {
        // Given
        let emtpyStringData = Data("".utf8)
        let expectedErrorCode: Int32 = 3
        let expectedErrorMessage = ExpectedErrorMessages.incorrectData.rawValue

        // When
        controller.outputView(view, dataRecievedFrom: emtpyStringData)

        // Then
        XCTAssertFalse(view.displaySuccessOutputInvoked)
        XCTAssertTrue(view.displayErrorMessageInvoked)
        XCTAssertEqual(view.passedErrorMessage, expectedErrorMessage)
        XCTAssertEqual(passedExitCode, expectedErrorCode)
    }

    func test_withMissedValue_returnMissingDataError() {
        // Given
        let expectedErrorCode: Int32 = 3
        let expectedErrorMessage = ExpectedErrorMessages.missingData.rawValue
        guard let inputData = DecodingErrorTestFileNames.missedValue.data
        else {
            XCTFail("failed to prepare input data")
            return
        }

        // When
        controller.outputView(view, dataRecievedFrom: inputData)

        // Then
        XCTAssertFalse(view.displaySuccessOutputInvoked)
        XCTAssertTrue(view.displayErrorMessageInvoked)
        XCTAssertEqual(view.passedErrorMessage, expectedErrorMessage)
        XCTAssertEqual(passedExitCode, expectedErrorCode)
    }

    func test_withMissedKey_returnMissingDataError() {
        // Given
        let expectedErrorCode: Int32 = 3
        let expectedErrorMessage = ExpectedErrorMessages.missingData.rawValue
        guard let inputData = DecodingErrorTestFileNames.keyNotFound.data
        else {
            XCTFail("failed to prepare input data")
            return
        }

        // When
        controller.outputView(view, dataRecievedFrom: inputData)

        // Then
        XCTAssertFalse(view.displaySuccessOutputInvoked)
        XCTAssertTrue(view.displayErrorMessageInvoked)
        XCTAssertEqual(view.passedErrorMessage, expectedErrorMessage)
        XCTAssertEqual(passedExitCode, expectedErrorCode)
    }

    func test_withTypeMismatch_returnIncorrectDataError() {
        // Given
        let expectedErrorCode: Int32 = 3
        let expectedErrorMessage = ExpectedErrorMessages.incorrectData.rawValue
        guard let inputData = DecodingErrorTestFileNames.typeMismatch.data
        else {
            XCTFail("failed to prepare input data")
            return
        }

        // When
        controller.outputView(view, dataRecievedFrom: inputData)

        // Then
        XCTAssertFalse(view.displaySuccessOutputInvoked)
        XCTAssertTrue(view.displayErrorMessageInvoked)
        XCTAssertEqual(view.passedErrorMessage, expectedErrorMessage)
        XCTAssertEqual(passedExitCode, expectedErrorCode)
    }
}

// MARK: - enum that stores error messages

enum ExpectedErrorMessages: String {
    case incorrectData = "The data couldn’t be read because it isn’t in the correct format."
    case missingData = "The data couldn’t be read because it is missing."
}
