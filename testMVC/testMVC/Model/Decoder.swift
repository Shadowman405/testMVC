import Foundation

/// Singletone class that contains methods to parse
/// JSON and converts result of parsing to structures
class JSONParser {
    static let sharedInstance = JSONParser()

    private init() {}

    func parseJSON(data: Data) -> [AllEmployees]? {
        do {
            return try JSONDecoder().decode([AllEmployees].self, from: data)
        } catch {
            print("Error parsing JSON: error)")
            return nil
        }
    }

    func personToCompany(persons: [AllEmployees]) -> [Company] {
        var companies = [Company]()

        for person in persons {
            for employee in person.people {
                let email = employee.email
                guard let companyName = extractDomainName(fromEmail: email)
                else { return [Company]() }

                if companies.contains(where: { $0.name == companyName }) {
                    if let index = companies.firstIndex(where: { $0.name == companyName }) {
                        companies[index].employees.append(employee)
                    }
                } else {
                    companies
                        .append(Company(
                            name: companyName,
                            employees: [employee],
                            team: person.team
                        ))
                }
            }
        }

        // Extracts company name from email-like string.
        func extractDomainName(fromEmail email: String) -> String? {
            guard let atIndex = email.firstIndex(of: "@") else {
                return nil
            }
            let domain = email.suffix(from: atIndex).dropFirst()
            guard let dotIndex = domain.firstIndex(of: ".") else {
                return nil
            }
            return String(domain.prefix(upTo: dotIndex))
        }

        return companies
    }
}

let decoder = JSONDecoder()
public let employes = try? decoder.decode([AllEmployees].self, from: jsonMockData ?? Data())

// MARK: - mock JSON
