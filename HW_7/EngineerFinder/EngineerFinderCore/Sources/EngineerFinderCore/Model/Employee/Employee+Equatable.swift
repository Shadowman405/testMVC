extension Employee: Equatable {
    /// Returns a Boolean value indicating whether two instances of `Employee` are equal.
    ///
    /// - Parameters:
    ///   - lhs: An `Employee` to compare.
    ///   - rhs: Another `Employee` to compare.
    /// - Returns: If the employees are equal, returns `true`. Otherwise `false`.
    /// - Note: Two employees are equal if they have the same full names and emails.
    static func == (lhs: Employee, rhs: Employee) -> Bool {
        lhs.email == rhs.email && lhs.fullName == rhs.fullName
    }
}
