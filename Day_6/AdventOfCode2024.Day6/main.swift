import Foundation
import System

var room: [[Character]] = []

let fileURL = FileManager.default.homeDirectoryForCurrentUser.appending(path: "source/AdventOfCode2024/Day_6/AoC2024_input.6")

for try await line in fileURL.lines {
    if line.isEmpty {
        continue
    }
    
    let lineArray = Array(line)
    room.append(lineArray)
}
print("Room size: " + String(room.count) + " x " + String(room[0].count))
var position: [Int] = [0, 0, 0]
for (lineIndex, line) in room.enumerated() {
    for (cellIndex, cell) in line.enumerated() {
        if cell == "^" {
            position = [lineIndex, cellIndex, 12]
        }
        if cell == ">" {
            position = [lineIndex, cellIndex, 3]
        }
        if cell == "v" {
            position = [lineIndex, cellIndex, 6]
        }
        if cell == "<" {
            position = [lineIndex, cellIndex, 9]
        }
    }
    if position[2] > 0 {
        break
    }
}
print("Guard position: [" + String(position[0]) + "," + String(position[1]) + "] facing: " + String(position[2]))

