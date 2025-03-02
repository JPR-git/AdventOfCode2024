import Foundation
import System

let inputFileURL = FileManager.default.homeDirectoryForCurrentUser.appending(
    path: "source/AdventOfCode2024/Day_16/AoC2024_input.16")

// MAIN
var map: [[Character]] = []

for try await line in inputFileURL.lines {
    map.append(Array(line))
}

var maze: Matrix = Matrix(data: map)
print("Warehouse: \(maze.rows)x\(maze.columns)")

guard var rCoordinates = maze.locateFirst("S") else {
    print("No reindeer found!")
    exit(1)
}
var reindeer = Reindeer(3, rCoordinates)
print("Reindeer: (\(reindeer.position.0):\(reindeer.position.1)) heading: \(reindeer.Direction())")

guard var exitCoordinates = maze.locateFirst("E") else {
    print("No Exit found!")
    exit(1)
}
print("Exit: (\(exitCoordinates.0):\(exitCoordinates.1))")

// Bellman-Ford
