//
//  Controller.swift
//  testMVC
//
//  Created by Maxim Mitin on 1.06.24.
//

import Foundation

public struct Controller {
    var mainView: MainView

    init(mainView: MainView, employees: [String] = [String]()) {
        self.mainView = mainView
        self.employees = employees
    }   

    

    func updateMainView() {
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
                    //print("\(employee.fullName); \(company.team); \(employee.email)")
                    mainView.printEmployees("\(employee.fullName); \(company.team); \(employee.email)")
                }
            }
        }

        //mainView.run()
    }
//    var employees = [String]()
//
//    mutating func sendData(data: Data) -> [String] {
//
//         func showEmployees() -> [String] {
//            let parsedEmployees = JSONParser.sharedInstance.parseJSON(data: jsonMockData!)
//
//            guard let unwrapedEmployees = parsedEmployees else { return [""]}
//
//            for person in unwrapedEmployees {
//                for personDetails in person.people {
//                    employees.append("\(personDetails.fullName); \(person.team); \(personDetails.email)")
//                }
//            }
//             return employees
//        }
//
//        return employees
//    }

    private var employees = [String]()

}
