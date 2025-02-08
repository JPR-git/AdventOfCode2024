import Foundation
import System

let inputFileURL = FileManager.default.homeDirectoryForCurrentUser.appending(
    path: "source/AdventOfCode2024/Day_12/AoC2024_sample.12")

// MAIN
var garden: [[Character]] = []

for try await line in inputFileURL.lines {
    if line.isEmpty {
        continue
    }

    let lineArray = Array(line)
    garden.append(lineArray)
}
print("Garden size: " + String(garden.count) + " x " + String(garden[0].count))

// eliminate single X


//                      X
// eliminate double XX  X

//                      X   X
// elminate tripple XXX XX  X
//                          X

