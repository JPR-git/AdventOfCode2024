import Foundation
import System

// MAIN
var diskMap: [Int] = []
let fileURL = FileManager.default.homeDirectoryForCurrentUser.appending(
    path: "source/AdventOfCode2024/Day_9/AoC2024_input.9")
let input: String = try String(contentsOf: fileURL, encoding: .ascii).trimmingCharacters(in: .whitespacesAndNewlines)
print("Line length: " + String(input.count))

var currentBlock: Int = 0
for index in stride(from: 0, through: input.count, by: 2) {
    let numberOfBlocks: Int = input[
        input.index(input.startIndex, offsetBy: index)
    ].wholeNumberValue!
    diskMap.append(
        contentsOf: [Int](repeating: currentBlock, count: numberOfBlocks))
    if index < input.count - 1 {
        let numberOfSpaces: Int = input[input.index(input.startIndex, offsetBy: index + 1)].wholeNumberValue!
        diskMap.append(contentsOf: [Int](repeating: -1, count: numberOfSpaces))
    }
    currentBlock += 1
}
print("diskMap length: " + String(diskMap.count))

// reshuffle
var firstSpace = diskMap.firstIndex(of: -1)!
var lastBlock = diskMap.lastIndex(where: {x in x >= -1})!

while(lastBlock > firstSpace) {
    //print(String(firstSpace) + " : " + String(lastBlock))
    diskMap[firstSpace] = diskMap[lastBlock]
    diskMap[lastBlock] = -1
    
    firstSpace = diskMap.firstIndex(of: -1)!
    lastBlock = diskMap.lastIndex(where: {x in x > -1})!
}

// calculate sum
var sum: Int = 0
for (index, value) in diskMap.enumerated() {
    if value > -1 {
        sum += index * value
    }
}

print(sum)
