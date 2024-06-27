/// Represents the team within the organization.
struct Team {
    /// The name of the team.
    let name: String
    /// List of the employees of the team.
    let employees: [Employee]
    /// List of subteams that are part of this team. Empty if the team has no subteams.
    let subteams: [Team]

    /// Creates a new instance of the team.
    /// - Parameters:
    ///   - name: The name of the team.
    ///   - employees: List of the employees of the team.
    ///   - subteams: List of subteams that are part of this team. Defaults to an empty array.
    init(name: String, employees: [Employee], subteams: [Team] = []) {
        self.name = name
        self.employees = employees
        self.subteams = subteams
    }
}
