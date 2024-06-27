import Foundation

/// The interface for delegates of `OutputView` to receive user input from standard input stream.
public protocol OutputViewDelegate: AnyObject {
    /// Notifies the delegate that the `OutputView` instance has received user input.
    ///
    /// - Parameters:
    ///   - OutputView: The `OutputView` instance that received the input from user.
    ///   - userInput: The data received from the standard input stream.
    func outputView(_ outputView: MessageDisplayable, dataRecievedFrom userInput: Data)
}
