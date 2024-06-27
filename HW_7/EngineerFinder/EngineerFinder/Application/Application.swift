import EngineerFinderCore

/// An interface to run application
public struct Application {
    private let view: OutputView
    private let controller: OutputController
    private let dataManager: OutputDataManager

    /// Initializes a new `Application` instance.
    public init() {
        view = OutputView()
        dataManager = OutputDataManager()
        controller = OutputController(view: view, dataManager: dataManager)
        view.setDelegate(controller)

        controller.exitHandlerWithExitCode = { exitCode in
            exit(exitCode)
        }
    }

    /// Launches the application.
    public func run() {
        view.handleUserInput()
    }
}
