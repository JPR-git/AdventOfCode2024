import Foundation
import System

func EvaluateNode2(_ result: Int, _ sum: Int,_ line: [Int],_ index: Int) -> Bool {
    //the last item in the array
    if (line.count == (index+1)) {
        if ((line[index] + sum) == result
            || (line[index] * sum) == result
            || Int(String(sum) + String(line[index]))! == result) {
            return true;
        }
        return false;
    }
    
    // operation +
    if EvaluateNode2(result, (sum + line[index]), line, index+1) {
        return true;
    }

    // operation *
    if(index == 1) {
        if (EvaluateNode2(result, (1 * line[index]), line, index+1)) {
            return true;
        }
    }
    
    if EvaluateNode2(result, (sum * line[index]), line, index+1) {
        return true;
    }
    
    // operation string-concat
    return EvaluateNode2(result, Int(String(sum) + String(line[index]))!, line, index+1)
}

func EvaluateNode(_ result: Int, _ sum: Int,_ line: [Int],_ index: Int) -> Bool {
    if result < sum { return false; }
    
    //the last item in the array
    if (line.count == (index+1)) {
        if ((line[index] + sum) == result || (line[index] * sum) == result) {
            return true;
        }
        return false;
    }
    
    // operation +
    if EvaluateNode(result, (sum + line[index]), line, index+1) {
        return true;
    }

    // operation *
    if(index == 1) {
        return EvaluateNode(result, (1 * line[index]), line, index+1)
    }
    return EvaluateNode(result, (sum * line[index]), line, index+1)
}

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
for (index, equation) in equationList.enumerated()  {
    let  x = equation[0]
    if(EvaluateNode(x, 0, equation, 1)) {
        //print(index, " ", x)
        result += x
    }
}
print("Sum:\t" + String(result))

result = 0
for (index, equation) in equationList.enumerated()  {
    let  x = equation[0]
    if(EvaluateNode2(x, 0, equation, 1)) {
        //print(index, " ", x)
        result += x
    }
}
print("Sum2:\t" + String(result))
