import Foundation
import System

// MAIN
let fileURL = FileManager.default.homeDirectoryForCurrentUser.appending(path: "source/AdventOfCode2024/Day_7/AoC2024_input.7")
let parsedLine = try Regex("^([0-9]+):(.+)$", as: (Substring, Substring, Substring).self)

var equationList: [[Int]] = []

for try await line in fileURL.lines {
    if line.isEmpty {
        continue
    }
    let match = line.firstMatch(of: parsedLine)
    
    var numbers: [Int] = []
    numbers.append(Int(match!.output.1)!)
    
    match!.output.2.trimmingCharacters(in: .whitespacesAndNewlines)
        .components(separatedBy: " ").forEach({ number in
            numbers.append(Int(number)!)
        })
    equationList.append(numbers)
}
print("Equation #: "+String(equationList.count))

