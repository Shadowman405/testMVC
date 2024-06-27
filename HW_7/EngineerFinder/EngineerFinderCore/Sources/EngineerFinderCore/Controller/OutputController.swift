import Foundation

/// The link between the application’s model and view layers.
/// With the help of which the view layer monitors the user's interaction with the application
/// and notifies the model layer about these interactions for subsequent processing.
public final class OutputController: OutputViewDelegate {
    /// The view that the controller manages and interacts with.
    private let view: MessageDisplayable
    private let dataManager: OutputDataManager

    /// The handler that give functionality to exit application with given exit code
    public var exitHandlerWithExitCode: ((Int32) -> Void)?

    /// Creates a new instance of the controller.
    /// - Parameter view: The `OutputView` instance
    /// that the controller will manage and interact with.
    public init(view: MessageDisplayable, dataManager: OutputDataManager) {
        self.view = view
        self.dataManager = dataManager
    }

    /// Receives user input from the console and processes it.
    /// - Parameter outputView: The `OutputView` instance that will display the processed data.
    /// - Parameter userInput: The data entered by user.
    /// If an error occurs, displays an error
    /// otherwise displays the data as a list of employees in company.
    public func outputView(_: MessageDisplayable, dataRecievedFrom userInput: Data) {
        let listOfEmployees = dataManager.buildListOfEmployees(from: userInput)

        switch listOfEmployees {
        case let .success(resultString):
            view.printResults(resultString)
            exitHandlerWithExitCode?(0)
        case let .failure(error):
            view.showError(error)
            exitHandlerWithExitCode?(3)
        }
    }
}
