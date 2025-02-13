import Foundation
import System

var totalPrice: Int = 0
let inputFileURL = FileManager.default.homeDirectoryForCurrentUser.appending(
    path: "source/AdventOfCode2024/Day_12/AoC2024_sample.12")

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

var shape: Shape = Shape.Detect(garden, 0, 0)

// calculate price
totalPrice += shape.calculatePrice()

// clean shape in Garden


print("Garden total price:\t\(totalPrice)")
