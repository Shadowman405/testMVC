/// Represents an employee in an organization.
struct Employee {
    /// The full name, including both first name and surname.
    let fullName: String
    /// Employee's email address.
    let email: String
    /// A list of co-workers who report directly to this employee.
    /// Empty if the employee has no direct reports.
    let reports: [Employee]

    /// Creates a new instance of the employee.
    /// - Parameters:
    ///   - fullName: The full name, including both first name and surname.
    ///   - email: Employee's email address.
    ///   - reports: A list of co-workers who report directly to this employee.
    ///   Defaults to an empty array.
    init(fullName: String, email: String, reports: [Employee] = []) {
        self.fullName = fullName
        self.email = email
        self.reports = reports
    }
}
