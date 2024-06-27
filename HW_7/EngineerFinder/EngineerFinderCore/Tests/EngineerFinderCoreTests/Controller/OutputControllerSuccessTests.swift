@testable import EngineerFinderCore
import XCTest

final class OutputControllerSuccessTests: XCTestCase {
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

    func test_withInputFromTeamValidAllFields_returnsExpectedOutput() {
        // Given
        let expectedExitCode: Int32 = 0
        guard let input = SuccesTestFileNames.teamValidAllFields.data
        else {
            XCTFail("failed to prepare input data")
            return
        }

        let expectedOutput = ExpectedOutputMessages.teamWithValidAllFields.rawValue

        // When
        controller.outputView(view, dataRecievedFrom: input)

        // Then
        XCTAssertEqual(passedExitCode, expectedExitCode)
        XCTAssertTrue(view.displaySuccessOutputInvoked)
        XCTAssertFalse(view.displayErrorMessageInvoked)
        XCTAssertEqual(view.passedSuccessOutput, expectedOutput)
    }

    func test_withInputFromTeamWithSubreports_returnsExpectedOutput() {
        // Given
        let expectedExitCode: Int32 = 0
        guard let input = SuccesTestFileNames.teamWithSubreports.data
        else {
            XCTFail("failed to prepare input data")
            return
        }

        let expectedOutput = ExpectedOutputMessages.teamWithSubreports.rawValue

        // When
        controller.outputView(view, dataRecievedFrom: input)

        // Then
        XCTAssertEqual(passedExitCode, expectedExitCode)
        XCTAssertTrue(view.displaySuccessOutputInvoked)
        XCTAssertFalse(view.displayErrorMessageInvoked)
        XCTAssertEqual(view.passedSuccessOutput, expectedOutput)
    }

    func test_withRecursiveTeams_returnsExpectedOutput() {
        // Given
        let expectedExitCode: Int32 = 0
        guard let input = SuccesTestFileNames.teamWithSubteams.data
        else {
            XCTFail("failed to prepare input data")
            return
        }

        let expectedOutput = ExpectedOutputMessages.teamWithSubteams.rawValue

        // When
        controller.outputView(view, dataRecievedFrom: input)

        // Then
        XCTAssertEqual(passedExitCode, expectedExitCode)
        XCTAssertTrue(view.displaySuccessOutputInvoked)
        XCTAssertFalse(view.displayErrorMessageInvoked)
        XCTAssertEqual(view.passedSuccessOutput, expectedOutput)
    }
}

// MARK: - enum that stores error messages

enum ExpectedOutputMessages: String {
    case teamWithValidAllFields = """

    GOOGLE:
    Barry Johnson; Engineering (Back-end); barryjohnson@gmail.com

    APPLE:
    Alex Bowman; Engineering (Back-end); alexbowman@apple.com

    """
    case teamWithSubreports = """

    APPLE:
    Alex Bowman; Engineering (iOS); alexbowman@apple.com
    Barry Johnson; Engineering (iOS); barryjohnson@apple.com

    EVANS:
    John Evans; Engineering (iOS); johnevans@evans.com

    YAHOO:
    David Wasserman; Engineering (iOS); dwasserman@yahoo.com

    """
    case teamWithSubteams = """

    APPLE:
    Alex Bowman; Engineering (iOS); alexbowman@apple.com
    Barry Johnson; Engineering (iOS) - Alpha; barryjohnson@apple.com

    EVANS:
    John Evans; Engineering (iOS) - Alpha - Beta - Gamma; johnevans@evans.com

    YAHOO:
    David Wasserman; Engineering (iOS) - Alpha - Beta; dwasserman@yahoo.com

    """
}
