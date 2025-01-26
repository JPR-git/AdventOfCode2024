import Foundation
import System

struct Position {
    var line = -1
    var column = -1
}

func calculateNumberOfTrails(_ nextValue: Int,_ positionLine: Int, _ positionColumn: Int) throws -> Int {
    // we are at the end for trail
    if nextValue == 10 {
        /*
        // For Task 1 we have to collect the position and eliminate duplicates
         if (positions.contains{ X in
             return X.line == positionLine && X.column == positionColumn }) {
                 return 0
        }
        positions.append( Position(line: positionLine, column:  positionColumn ))
        */
        return 1
    }
    
    var trailHeadsNumber: Int = 0
    
    // UP
    if positionLine > 0 &&
        (map[positionLine-1][positionColumn] == nextValue) {
        trailHeadsNumber += try calculateNumberOfTrails(nextValue+1, positionLine-1, positionColumn)
    }
    
    // DOWN
    if positionLine+1 < map.count &&
        (map[positionLine+1][positionColumn] == nextValue) {
        trailHeadsNumber += try calculateNumberOfTrails(nextValue+1, positionLine+1, positionColumn)
    }
    // RIGHT
    if positionLine < map.count &&
        map[positionLine].count > positionColumn+1 &&
        (map[positionLine][positionColumn+1] == nextValue) {
        trailHeadsNumber += try calculateNumberOfTrails(nextValue+1, positionLine, positionColumn+1)
    }
    // LEFT
    if positionLine < map.count &&
        positionColumn > 0 &&
        (map[positionLine][positionColumn-1] == nextValue) {
        trailHeadsNumber += try calculateNumberOfTrails(nextValue+1, positionLine, positionColumn-1)
    }
    
    return trailHeadsNumber
}

let inputFileURL = FileManager.default.homeDirectoryForCurrentUser.appending(
    path: "source/AdventOfCode2024/Day_10/AoC2024_input.10")

// MAIN
var map: [[Int]] = []
var positions: [Position] = []

for try await line in inputFileURL.lines {
    if line.isEmpty {
        continue
    }

    var buffer: [Int] = []
    let lineArray = Array(line)
    lineArray.forEach { buffer.append(($0).wholeNumberValue ?? -1) }
    map.append(buffer)
}

var sum: Int = 0
// find trailheads one by one
for (lineIndex, line) in map.enumerated() {
    for (columnIndex, cell) in line.enumerated() {
        if cell == 0 {
            // trailhead found
            // position [lineIndex, columnIndex]
            positions = []
            sum += try calculateNumberOfTrails(1, lineIndex, columnIndex)
        }
    }
}

// over (for sample should be 36)
print(sum)
