import Foundation

func run() {
    let manager = JSONParser.sharedInstance

    if let data = jsonMockData {
        let persons = manager.parseJSON(data: data)

        if let persons {
            let companies = manager.personToCompany(persons: persons)
            printCompaniesandEmployeesInIt(companies)
        }
    }

    func printCompaniesandEmployeesInIt(_ companies: [Company]) {
        for company in companies {
            print("\n\(company.name.uppercased()):")
            for employee in company.employees {
                print("\(employee.fullName); \(company.team); \(employee.email)")
            }
        }
    }
}

run()
