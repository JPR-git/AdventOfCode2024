import Foundation
import System

let inputFileURL = FileManager.default.homeDirectoryForCurrentUser.appending(
    path: "source/AdventOfCode2024/Day_11/AoC2024_input.11")

let MaxIterationCount: Int = 75
var MemoizationCache: [IterationCoordinates : Int] = [:]

func blink(_ stone: Int, _ iteration: Int) -> Int {
    if MemoizationCache.keys.contains(IterationCoordinates(stone, iteration)) {
        return MemoizationCache[IterationCoordinates(stone, iteration)]!
    }
    
    if iteration == 0 {
        return 1
    }
    
    if 0 == stone {
        MemoizationCache[IterationCoordinates(stone, iteration)] = blink(1, iteration - 1)
    } else if (String(stone).count % 2 == 0) {
        // even number of digits -> split into text halfs
        let text = String(stone)
        let indexOfHalfLeft = text.index(text.startIndex, offsetBy: (Int)(text.count-1)/2)
        let indexOfHalfRight = text.index(text.startIndex, offsetBy: text.count/2)
        
        let leftHalf: Int = Int(String(text[...indexOfHalfLeft]))!
        let rightHalf: Int = Int(String(text[indexOfHalfRight...]))!
        
        MemoizationCache[IterationCoordinates(stone, iteration)] = blink(leftHalf, iteration - 1) + blink(rightHalf, iteration - 1)
    } else {
        MemoizationCache[IterationCoordinates(stone, iteration)] = blink(2024 * stone, iteration - 1)
    }
    
    return MemoizationCache[IterationCoordinates(stone, iteration)]!
}

// MAIN
let input: String = try String(contentsOf: inputFileURL, encoding: .ascii).trimmingCharacters(in: .whitespacesAndNewlines)
var numberLine: [Int] = []
input.split(separator: " ").forEach { numberStr in
    numberLine.append(Int(numberStr)!)
}


var sum: Int = 0
for(numberIndex, number) in numberLine.enumerated() {
    
    let result: Int = blink(number, MaxIterationCount)
    print("[\(numberIndex)] \(number): \(result)")
    sum += result
}

print(sum)
