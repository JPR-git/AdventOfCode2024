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
                            var foundHarmonicFrequency: Bool = false
                            
                            let difY = columnIndex2 - columnIndex
                            let difX = lineIndex2 - lineIndex

                            // point alpha ... cell2
                            var alphaX = lineIndex2 + difX
                            var alphaY = columnIndex2 + difY
                            while(alphaX >= 0 && alphaX < room.count &&
                                    alphaY >= 0 && alphaY < room[alphaX].count)
                            {
                                result.append((alphaX, alphaY))
                                foundHarmonicFrequency = true
                                alphaX = alphaX + difX
                                alphaY = alphaY + difY
                            }

                            // point beta ... cell
                            var betaX = lineIndex - difX
                            var betaY = columnIndex - difY
                            while(betaX >= 0 && betaX < room.count &&
                                betaY >= 0 && betaY < room[betaX].count)
                            {
                                result.append((betaX, betaY))
                                foundHarmonicFrequency = true
                                betaX = betaX - difX
                                betaY = betaY - difY
                            }
                            
                            // I think this is a bug
                            //if foundHarmonicFrequency {
                                result.append((lineIndex, columnIndex))
                                result.append((lineIndex2, columnIndex2))
                            
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
let outputURL = FileManager.default.homeDirectoryForCurrentUser.appending(
    path: "source/AdventOfCode2024/Day_8/AoC2024_output.8")

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
    line.forEach({ cell in
        if cell != "." {
            sum += 1
        }
    })
})
print(sum)

// save to file
do {
    var builder = ""
    shadowRoom.forEach({ line in
        line.forEach( { cell in
            builder += String(cell)
        })
        builder += String("\n")
    })
    try builder.write(toFile: outputURL.path, atomically: true, encoding: .ascii)
} catch let error {
    // handle error
    print("Error on writing strings to file: \(error)")
}

