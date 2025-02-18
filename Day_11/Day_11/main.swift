import Foundation
import System

let inputFileURL = FileManager.default.homeDirectoryForCurrentUser.appending(
    path: "source/AdventOfCode2024/Day_11/AoC2024_pattern.11")

let MaxIterationCount: Int = 40
let MaxChunkSize: Int = 11000000

var ThreadList: [CalculatingThread] = []
// Preparation

var calculatedValues = [Int: Int]()
for i in 0...50 {
    let calculatingThread = CalculatingLevel35Thread(i, i)
    calculatingThread.start()
    //ThreadList.append(calculatingThread)
    calculatingThread.join()
    print("\(calculatingThread.index) : \(calculatingThread.result)")
    calculatedValues[calculatingThread.index] = calculatingThread.result
}


// MAIN
let input: String = try String(contentsOf: inputFileURL, encoding: .ascii).trimmingCharacters(in: .whitespacesAndNewlines)
var numberLine: [Int] = []
input.split(separator: " ").forEach { numberStr in
    numberLine.append(Int(numberStr)!)
}


ThreadList = []
let clock = ContinuousClock()
let result = clock.measure {
    for(numberIndex, number) in numberLine.enumerated() {
    // each number in its own thread
    let calculatingThread = CalculatingThread(numberIndex, number, MaxIterationCount)
    calculatingThread.start()
    ThreadList.append(calculatingThread)
    //calculatingThread.join()
}

var someNotFinished = true
    while someNotFinished {
        someNotFinished = false
        for thread in ThreadList {
            if !thread.isFinished {
                someNotFinished = true
            }
        }
        if someNotFinished { usleep(10) }
    }
}
print(result)
print("==============================")
var sum: Int = 0
for thread in ThreadList {
    sum += thread.result
    print("\(thread.index) : \(thread.result)")
}

//let sum = Iterate(0, numberLine)
print("==============================")
print(sum)
// over  for 25 it is 233050
