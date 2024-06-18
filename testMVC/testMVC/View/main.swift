import Foundation

// protocol MainViewDelegate {
//    func update()
// }

struct MainView {
    // var delegate: MainViewDelegate?

    func run() {
//        let manager = JSONParser.sharedInstance
//
//        if let data = jsonMockData {
//            let persons = manager.parseJSON(data: data)
//
//            if let persons {
//                let companies = manager.personToCompany(persons: persons)
//                printCompaniesandEmployeesInIt(companies)
//            }
//        }
//
//        func printCompaniesandEmployeesInIt(_ companies: [Company]) {
//            for company in companies {
//                print("\n\(company.name.uppercased()):")
//                for employee in company.employees {
//                    print("\(employee.fullName); \(company.team); \(employee.email)")
//                }
//            }
//        }
//
//        //print("Hello, World! This is my command line tool")
//
//        let arguments = CommandLine.arguments
//        if arguments.count > 1 {
//            let filePath = arguments[1]
//            do {
//                let contents = try String(contentsOfFile: filePath, encoding: .utf8)
//                print(contents)
//            } catch {
//                print("Error reading file")
//            }
//        } else {
//            print("SOmething went wrong")
//        }
        //        let stdin = FileHandle.standardInput
        //        let dataFromJson = stdin.availableData
        //        let input = String(data: dataFromJson, encoding: .utf8)!
        //        print("You entered: \(input)")

        // MARK: - Working variant

//        func updateMainView() {
//            let stdin = FileHandle.standardInput
//            let dataFromJson = stdin.availableData
//
//            let manager = JSONParser.sharedInstance
//
//                let persons = manager.parseJSON(data: dataFromJson)
//
//                if let persons {
//                    let companies = manager.personToCompany(persons: persons)
//                    printCompaniesandEmployeesInIt(companies)
//                }
//
//            func printCompaniesandEmployeesInIt(_ companies: [Company]) {
//                for company in companies {
//                    print("\n\(company.name.uppercased()):")
//                    for employee in company.employees {
//                       
//        printEmployees("\(employee.fullName ?? ""); \(company.team); \(employee.email ?? "")")
//                    }
//                }
//            }
//
//            func printEmployees(_ someString: String?) {
//                print(someString ?? "")
//
//            }
    }

    func printEmployees(_ someString: String?) {
        print(someString ?? "")
    }
}

let mainView = MainView()
let controller = Controller(mainView: mainView)

controller.updateMainView()
