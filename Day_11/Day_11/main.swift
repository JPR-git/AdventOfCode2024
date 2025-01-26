import Foundation
import System


func ProcessStone(_ index: Int) -> Int {
    if(index >= numberLine.count) { return 0 }
    
    let val = numberLine[index]
    
    // 0 -> 1
    if val == 0{
        numberLine[index] = 1
    }
    // even number of digits -> split into text halfs
    else if (String(val).count % 2 == 0) {
        let text = String(val)
        let indexOfHalfLeft = text.index(text.startIndex, offsetBy: (Int)(text.count-1)/2)
        let indexOfHalfRight = text.index(text.startIndex, offsetBy: text.count/2)
        
        let leftHalf: String = String(text[...indexOfHalfLeft])
        let rightHalf: String = String(text[indexOfHalfRight...])
        numberLine[index] = Int(leftHalf)!
        let secondIndex = index + 1
        numberLine.insert(Int(rightHalf)!, at: secondIndex)
        return ProcessStone(index+2)
    }
    // anything else -> *2024
    else {
        numberLine[index] = 2024 * val
    }
    
    return ProcessStone(index+1)
}

let inputFileURL = FileManager.default.homeDirectoryForCurrentUser.appending(
    path: "source/AdventOfCode2024/Day_11/AoC2024_input.11")

var numberLine: [Int] = []
// MAIN
let input: String = try String(contentsOf: inputFileURL, encoding: .ascii).trimmingCharacters(in: .whitespacesAndNewlines)
    
input.split(separator: " ").forEach { numberStr in
    numberLine.append(Int(numberStr)!)
}

for i in 0..<75 {
    //_ = ProcessStone(0)
    var index: Int = 0
    
    repeat {
        let val = numberLine[index]
        
        // 0 -> 1
        if val == 0{
            numberLine[index] = 1
        }
        // even number of digits -> split into text halfs
        else if (String(val).count % 2 == 0) {
            let text = String(val)
            let indexOfHalfLeft = text.index(text.startIndex, offsetBy: (Int)(text.count-1)/2)
            let indexOfHalfRight = text.index(text.startIndex, offsetBy: text.count/2)
            
            let leftHalf: String = String(text[...indexOfHalfLeft])
            let rightHalf: String = String(text[indexOfHalfRight...])
            numberLine[index] = Int(leftHalf)!
            let secondIndex = index + 1
            numberLine.insert(Int(rightHalf)!, at: secondIndex)
            index += 1
        }
        // anything else -> *2024
        else {
            numberLine[index] = 2024 * val
        }
        
        index += 1
    } while (index < numberLine.count)
    print("\(i) : \(numberLine.count)")
}

// over
print(numberLine.count)
