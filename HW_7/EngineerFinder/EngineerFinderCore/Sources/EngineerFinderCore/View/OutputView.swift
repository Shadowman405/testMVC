import Foundation

/// A view that reads and transmits user-entered data from the standard input stream
/// and outputs the result of processing the entered data to the output stream.
public final class OutputView: MessageDisplayable {
    /// The delegate that processes the input entered by the user.
    private weak var delegate: OutputViewDelegate?

    public init() {}

    /// Sets the view's delegate.
    /// - Parameter delegate: An object conforming to the `OutputViewDelegate`
    /// protocol that will processes events.
    public func setDelegate(_ delegate: OutputViewDelegate) {
        self.delegate = delegate
    }

    /// Handles user interaction with the application.
    /// Converts user input from standard input into `Data`.
    public func handleUserInput() {
        let dataFromStandardInput = FileHandle.standardInput.availableData
        delegate?.outputView(self, dataRecievedFrom: dataFromStandardInput)
    }

    /// Outputs the result of data processing to the output stream.
    /// - Parameter result: The result to display.
    public func printResults(_ result: String) {
        print(result)
    }

    /// Writes an error message into the standard error stream.
    /// - Parameter error: The error to display.
    public func showError(_ error: Error) {
        let errorDescription = "\(error.localizedDescription)\n"
        fputs(errorDescription, stderr)
    }
}
