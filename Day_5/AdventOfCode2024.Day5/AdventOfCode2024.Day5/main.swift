import Foundation
import System

var rules: [[Int]] = []
var pages: [[Int]] = []

let fileURL = FileManager.default.homeDirectoryForCurrentUser.appending(path: "source/AdventOfCode2024/Day_5/AoC2024_input.5.1")

let ruleRegex = try Regex("([0-9]{2})\\|([0-9]{2})", as: (Substring, Substring, Substring).self)

for try await line in fileURL.lines {
    if line.isEmpty {
        continue
    }
    
    line.matches(of: ruleRegex).forEach( {match in
        //print(match.output)
        rules.append([(Int(match.output.1) ?? 0), (Int(match.output.2) ?? 0)])
    })
}
let _ = print("Rules #: " + String(rules.count))

let fileURL2 = FileManager.default.homeDirectoryForCurrentUser.appending(path: "source/AdventOfCode2024/Day_5/AoC2024_input.5.2")
for try await line in fileURL2.lines {
    if line.isEmpty {
        continue
    }
    
    var numbers: [Int] = []
    line.components(separatedBy: ",").forEach({ number in
        numbers.append(Int(number) ?? 0 )
    })
    pages.append(numbers)
}
let _ = print("Pages #: " + String(pages.count))


