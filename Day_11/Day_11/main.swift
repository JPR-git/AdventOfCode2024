import Foundation
import System

let inputFileURL = FileManager.default.homeDirectoryForCurrentUser.appending(
    path: "source/AdventOfCode2024/Day_11/AoC2024_input.11")

let MaxIterationCount: Int = 75
let MaxChunkSize: Int = 5000000

// MAIN
let input: String = try String(contentsOf: inputFileURL, encoding: .ascii).trimmingCharacters(in: .whitespacesAndNewlines)
var numberLine: [Int] = []
input.split(separator: " ").forEach { numberStr in
    numberLine.append(Int(numberStr)!)
}


var threadList: [CalculatingThread] = []
for(numberIndex, number) in numberLine.enumerated() {
    // each number in its own thread
    var calculatingThread = CalculatingThread(numberIndex, number, MaxIterationCount)
    calculatingThread.start()
    threadList.append(calculatingThread)
    //calculatingThread.join()
}

var someNotFinished: Bool = true
while someNotFinished {
    someNotFinished = false
    for thread in threadList {
        if !thread.isFinished {
            someNotFinished = true
        }
    }
    usleep(120)
}
print("==============================")
var sum: Int = 0
for thread in threadList {
    sum += thread.result
    print("\(thread.index) : \(thread.result)")
}

//let sum = Iterate(0, numberLine)
print("==============================")
print(sum)
// over  for 25 it is 233050
