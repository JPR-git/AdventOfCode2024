import Foundation
import System

var room: [[Character]] = []

// MAIN
let fileURL = FileManager.default.homeDirectoryForCurrentUser.appending(path: "source/AdventOfCode2024/Day_8/AoC2024_input.8")

for try await line in fileURL.lines {
    if line.isEmpty {
        continue
    }
    
    let lineArray = Array(line)
    room.append(lineArray)
}
print("Room size: " + String(room.count) + " x " + String(room[0].count))
