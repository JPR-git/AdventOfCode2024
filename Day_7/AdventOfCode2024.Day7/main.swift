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

var result: Int = 0
for (_, equation) in equationList.enumerated()  {
    
    //var sum: Int = 0
    
    var starCount: Int = 0 // number of * from the left; the rest is +
    repeat{
        var tempSum: Int = (starCount>0) ? 1 : 0
        
        var tempStar: Int = starCount
        
        for number in equation[1...] {
            if(tempStar > 0) {
                tempSum *= number
                tempStar -= 1
            } else {
                
                tempSum += number
            }
        }
        if(tempSum == equation[0]) {
            result += tempSum
            break;
        }
        
        starCount += 1
    } while(starCount < equation.count-2)
}
print("Sum: " + String(result))
