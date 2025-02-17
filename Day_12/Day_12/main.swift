import Foundation
import System

var totalPrice: Int = 0
let inputFileURL = FileManager.default.homeDirectoryForCurrentUser.appending(
    path: "source/AdventOfCode2024/Day_12/AoC2024_input.12")

// MAIN
var Garden: [[Character]] = []

for try await line in inputFileURL.lines {
    if line.isEmpty {
        continue
    }

    let lineArray = Array(line)
    Garden.append(lineArray)
}
print("Garden size: " + String(Garden.count) + " x " + String(Garden[0].count))

var garden = Matrix<Character>.init(data: Garden)

for r in (0...(garden.rows - 1)) {
    for c in (0...(garden.columns - 1)) {
        if garden[r,c] == Shape.ClearSymbol {
            continue
        }
        
        let shape: Shape = Shape.Detect(garden, r, c)

        // calculate price
        totalPrice += shape.calculatePriceAsTask2()

        // clean shape in Garden
        _ = garden.clear(Shape: shape, ClearSymbol: Shape.ClearSymbol)
    }
}

// large = 1206
print("Garden total price:\t\(totalPrice)")
