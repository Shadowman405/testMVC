@testable import EngineerFinderCore

/// A mock of `OutputView` used for testing.
final class OutputViewMock: MessageDisplayable {
    /// Indicates whether the `printResults(_ result: String)` method has been invoked.
    var displaySuccessOutputInvoked = false
    /// Stores the text passed to the `printResults(_ result: String)` method.
    var passedSuccessOutput: String?

    /// Indicates whether the `showError(_ error: Error)` method has been invoked.
    var displayErrorMessageInvoked = false
    /// Stores the text passed to the `showError(_ error: Error)` method.
    var passedErrorMessage: String?

    /// Mocks the display of a success message.
    /// - Parameter result: The success message text to be displayed.
    func printResults(_ result: String) {
        displaySuccessOutputInvoked = true
        passedSuccessOutput = result
    }

    /// Mocks the display of an error message.
    /// - Parameter error: The error message text to be displayed.
    func showError(_ error: Error) {
        displayErrorMessageInvoked = true
        passedErrorMessage = error.localizedDescription
    }
}
