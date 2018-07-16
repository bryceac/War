import Foundation

class Dialogue: NSObject, Codable {
    var report: String!
    var choices: [String] = [String]()
    
    enum CodingKeys: String, CodingKey {
        case report, choices
    }
    
    init(report: String!, choices: [String]) {
        self.report = report
        self.choices.append(contentsOf: choices)
    }
    
    func activate() ->Int {
        print(self.report)
        
        for choice in self.choices {
            print(String(self.choices.index(of: choice)!+1) + ". " + choice)
        }
        
        var option = 0
        
        repeat {
            print("Enter choice: ")
            option = Int(readLine()!)!
        } while (option < 0 || option > choices.count)
        
        return option
    }
}
