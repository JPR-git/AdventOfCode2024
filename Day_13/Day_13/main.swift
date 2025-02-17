import Foundation
import System

let inputFileURL = FileManager.default.homeDirectoryForCurrentUser.appending(
    path: "source/AdventOfCode2024/Day_13/AoC2024_input.13")

var machines: [Machine] = []

// MAIN
var lines: [String] = []
for try await line in inputFileURL.lines {
    if lines.count == 3 {
        machines.append(try Machine(lines))
        lines = []
    } else {
        lines.append(line)
    }
}

print(machines.count)
