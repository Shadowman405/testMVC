extension Team: Equatable {
    /// Returns a Boolean value indicating whether two instances of `Team` are equal.
    ///
    /// Equality is determined by comparing the `name`, `employees`, and `subteams` properties.
    ///
    /// - Parameters:
    ///   - lhs: An `Team` to compare.
    ///   - rhs: Another `Team` to compare.
    /// - Returns: If the teams are equal, returns `true`. Otherwise `false`.
    /// - Note: Two teams are equal if they have the same names, employees and subteams.
    static func == (lhs: Team, rhs: Team) -> Bool {
        lhs.name == rhs.name && lhs.employees == rhs.employees && lhs.subteams == rhs.subteams
    }
}
