/// Defines the interface for displaying output.
public protocol MessageDisplayable {
    /// Presents a text message to the user.
    /// - Parameter result: The result to display.
    func printResults(_ result: String)

    /// Presents an error message to the user.
    /// - Parameter error: The error to display.
    func showError(_ error: Error)
}
