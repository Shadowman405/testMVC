/// A utility for creating a list representation of employees
/// organized by the company name that was extracted from the employee's email domain.
enum OutputDataBuilder {
    /// Returns a string representation of employees grouped by company name from a list of teams.
    /// - Parameter teams: The list of teams to process.
    /// - Returns: A table of employees grouped by their company name.
    /// - Complexity: Time: O(`N`), where `N` is the number
    ///  of all teams and their subteams members.
    /// Space: O(`N`), where `N` is the number of all teams and their subteams members.
    static func buildStringRepresentation(of teams: [Team]) -> String {
        let employees = employees(from: teams)
        let employeesByCompanyName = employeesByCompanyName(from: employees)
        return employeesByCompanyName.description
    }

    /// Groups employees by the names of their companies that were extracted from the email domain.
    /// - Parameter employees: The list of employees to group.
    /// - Returns: The employees grouped by company name.
    private static func employeesByCompanyName(
        from employees: [EmployeeWithTeam]
    ) -> [String: [EmployeeWithTeam]] {
        let unknownCompanyName = "Unknown Company"

        var employeesByCompanyName = [String: [EmployeeWithTeam]]()

        for employeeWithTeam in employees {
            let companyName = EmailHandler
                .extractCompanyName(fromEmail: employeeWithTeam.employee.email)
                ?? unknownCompanyName

            var employeesWithCompanyName = employeesByCompanyName[companyName, default: []]

            if let index = employeesWithCompanyName.firstIndex(where: {
                $0.employee == employeeWithTeam.employee
            }) {
                let employeeWithCompanyName = employeesWithCompanyName.remove(at: index)
                employeesWithCompanyName.insert(
                    employeeWithCompanyName + employeeWithTeam, at: index
                )
            } else {
                employeesWithCompanyName.append(employeeWithTeam)
            }

            employeesByCompanyName[companyName] = employeesWithCompanyName
        }

        return employeesByCompanyName
    }

    /// Deletes employees with invalid email addresses.
    /// - Parameter employeesToCheck: The list of employees to process.
    /// - Returns: The list of employees with valid email addresses.
    private static func deleteEmployeesWithInvalidEmail(
        from employeesToCheck: [EmployeeWithTeam]
    ) -> [EmployeeWithTeam] {
        var employeesWithValidEmails = [EmployeeWithTeam]()

        for employee in employeesToCheck where
            EmailHandler.validateEmail(employee.employee.email)
        {
            employeesWithValidEmails.append(employee)
        }

        return employeesWithValidEmails
    }

    /// Extracts the list of employees combined with their team name from the list of teams.
    /// - Parameter teams: The list of teams to process.
    /// - Returns: The list of employees combined with their team name and verified emails.
    private static func employees(from teams: [Team]) -> [EmployeeWithTeam] {
        let employeesWithUnverifiedEmails = teams.flatMap {
            fetchEmployeesFromTeam($0, appending: nil)
        }
        return deleteEmployeesWithInvalidEmail(from: employeesWithUnverifiedEmails)
    }

    /// Recursively fetches employees and their reports from a team and its subteams,
    /// appending the team prefix to each employee.
    /// - Parameters:
    ///   - team: The team to process.
    ///   - teamPrefix: The prefix to append to the team name, if any.
    /// - Returns: The list of employees combined with their team name.
    private static func fetchEmployeesFromTeam(
        _ team: Team,
        appending teamPrefix: String?
    ) -> [EmployeeWithTeam] {
        let teamPartsConcatenator = " - "

        let currentTeamFullName: String = if let teamPrefix {
            teamPrefix + teamPartsConcatenator + team.name
        } else {
            team.name
        }

        if team.subteams.isEmpty {
            return team.employees.flatMap {
                fetchReportsFromEmployee($0, teamName: currentTeamFullName)
            }
        }

        return team.employees.map { EmployeeWithTeam(employee: $0, team: currentTeamFullName) }
            + team.subteams.flatMap { fetchEmployeesFromTeam($0, appending: currentTeamFullName) }
    }

    /// Recursively fetches employees from an employee's direct reports,
    /// appending the team prefix to each employee.
    /// - Parameters:
    ///   - employee: The employee to process.
    ///   - teamName: The team name the employee and his reposts belong to.
    /// - Returns: The list of employees combined with their team name.
    private static func fetchReportsFromEmployee(
        _ employee: Employee,
        teamName: String
    ) -> [EmployeeWithTeam] {
        let isEmployeeMissingData = employee.email.isEmpty || employee.fullName.isEmpty

        let employeesWithTeam = employee.reports.flatMap {
            fetchReportsFromEmployee($0, teamName: teamName)
        }

        if isEmployeeMissingData {
            return employeesWithTeam
        } else {
            return [EmployeeWithTeam(employee: employee, team: teamName)] + employeesWithTeam
        }
    }
}

// MARK: - EmployeeWithTeam

/// A utility container holding an `Employee` instance and the related team name.
private struct EmployeeWithTeam {
    let employee: Employee
    let team: String
}

extension EmployeeWithTeam: CustomStringConvertible {
    /// A textual representation of the `EmployeeWithTeam` instance.
    var description: String {
        let concatenator = "; "
        return employee.fullName + concatenator + team + concatenator + employee.email
    }
}

extension EmployeeWithTeam {
    /// Merges two `EmployeeWithTeam` instances  representing the same employee.
    /// - Parameters:
    ///   - lhs: The first `EmployeeWithTeam` instance.
    ///   - rhs: The second `EmployeeWithTeam` instance.
    /// - Returns: A new `EmployeeWithTeam` instance with the same employee
    /// but concatenated team names.
    /// - Note: Two employees are equal if they have the same full names and emails.
    static func + (lhs: Self, rhs: Self) -> Self {
        let concatenator = ", "
        return Self(employee: lhs.employee, team: lhs.team + concatenator + rhs.team)
    }
}

private extension [String: [EmployeeWithTeam]] {
    /// A textual representation of the dictionary of employees grouped by email domain.
    /// - Complexity: O(`N`), where `N` is the number of all employees in the dictionary.
    var description: String {
        let newlineCharacter = "\n"
        let sectionNamePostfix = ":"

        var resultString = ""

        for (emailDomain, employeeWithTeam) in sorted(by: { $0.key < $1.key }) {
            resultString += newlineCharacter
            resultString += emailDomain.uppercased() + sectionNamePostfix + newlineCharacter
            resultString += employeeWithTeam
                .sorted { $0.employee.fullName < $1.employee.fullName }
                .map(\.description)
                .joined(separator: newlineCharacter)
            resultString += newlineCharacter
        }

        return resultString
    }
}
