import Foundation
import System

var room: [[Character]] = []
var shadowRoom: [[Character]] = []

func SearchPairsOf(_ positionX: Int, _ positionY: Int, _ value: Character) -> [(Int, Int)] {
    var result: [(Int, Int)] =  []
    for (lineIndex, line) in room.enumerated() {
        for (columnIndex, cell) in line.enumerated() {
            if cell != "." {
                // search for mirror
                for (lineIndex2, line2) in room.enumerated() {
                    for (columnIndex2, cell2) in line2.enumerated() {
                        if cell == cell2 && lineIndex != lineIndex2
                            && columnIndex != columnIndex2
                        {
                            let difY = columnIndex2 - columnIndex
                            let difX = lineIndex2 - lineIndex

                            // point alpha ... cell2
                            let alphaX = lineIndex2 + difX
                            let alphaY = columnIndex2 + difY
                            if alphaX >= 0 && alphaX < room.count &&
                                alphaY >= 0 && alphaY < line.count
                            {
                                result.append((alphaX, alphaY))
                            }

                            // point beta ... cell
                            let betaX = lineIndex - difX
                            let betaY = columnIndex - difY
                            if betaX >= 0 && betaX < room.count &&
                                betaY >= 0 && betaY < line.count
                            {
                                result.append((betaX, betaY))
                            }
                        }
                    }
                }
            }
        }
    }
    return result
}

// MAIN
let fileURL = FileManager.default.homeDirectoryForCurrentUser.appending(
    path: "source/AdventOfCode2024/Day_8/AoC2024_input.8")

for try await line in fileURL.lines {
    if line.isEmpty {
        continue
    }

    let lineArray = Array(line)
    room.append(lineArray)
}
print("Room size: " + String(room.count) + " x " + String(room[0].count))

room.forEach({ line in
    shadowRoom.append([Character](repeating: ".", count: line.count))
})
print(
    "Shadow Room size: " + String(shadowRoom.count) + " x "
        + String(shadowRoom[0].count))

// evaluate each cell in room
for (lineIndex, line) in room.enumerated() {
    for (columnIndex, cell) in line.enumerated() {
        if cell != "." {
            let result = SearchPairsOf(lineIndex, columnIndex, cell)
            if !result.isEmpty {
                result.forEach({ point in
                    shadowRoom[point.0][point.1] = "#"
                })
            }
        }
    }
}

// evaluate
var sum: Int = 0
shadowRoom.forEach({ line in
    line.forEach({
        if $0 == "#" {
            sum += 1
        }
    })
})
print(sum)
