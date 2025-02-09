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

// eliminate single X
var update = HandleRegion1X(&Garden)
print("Single X border count:\t\(update)")
totalPrice += update

//                      X
// eliminate double XX  X
update = HandleRegion2X(&Garden)
print("Double X border count:\t\(update)")
totalPrice += update

//                      X   X
// elminate tripple XXX XX  X
//                          X



print("Garden total price:\t\(totalPrice)")
