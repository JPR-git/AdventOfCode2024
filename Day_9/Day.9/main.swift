import Foundation
import System


// MAIN
let outputURL = FileManager.default.homeDirectoryForCurrentUser.appending(
    path: "source/AdventOfCode2024/Day_9/AoC2024_array.9")
let finalOutputURL = FileManager.default.homeDirectoryForCurrentUser.appending(
    path: "source/AdventOfCode2024/Day_9/AoC2024_final.9")


var diskMap: [Int] = []
let fileURL = FileManager.default.homeDirectoryForCurrentUser.appending(
    path: "source/AdventOfCode2024/Day_9/AoC2024_sample.9")
let input: String = try String(contentsOf: fileURL, encoding: .ascii).trimmingCharacters(in: .whitespacesAndNewlines)
print("Line length: " + String(input.count))

var currentBlock: Int = -1
for index in stride(from: 0, through: input.count, by: 2) {
    currentBlock += 1
    let numberOfBlocks: Int = input[
        input.index(input.startIndex, offsetBy: index)
    ].wholeNumberValue!
    diskMap.append(
        contentsOf: [Int](repeating: currentBlock, count: numberOfBlocks))
    if index < input.count - 1 {
        let numberOfSpaces: Int = input[input.index(input.startIndex, offsetBy: index + 1)].wholeNumberValue!
        diskMap.append(contentsOf: [Int](repeating: -1, count: numberOfSpaces))
    }
}
print("diskMap length: " + String(diskMap.count))

// save to file
do {
    var builder = ""
    
        diskMap.forEach( { cell in
            if(cell == -1) {
                builder += "."
            } else {
                builder += String(cell)
            }
        })
    try builder.write(toFile: outputURL.path, atomically: true, encoding: .ascii)
} catch let error {
    // handle error
    print("Error on writing strings to file: \(error)")
}

// task 1 - reshuffle
/*
var firstSpace = diskMap.firstIndex(of: -1)!
var lastBlock = diskMap.lastIndex(where: {x in x >= -1})!

while(lastBlock > firstSpace) {
    //print(String(firstSpace) + " : " + String(lastBlock))
    diskMap[firstSpace] = diskMap[lastBlock]
    diskMap[lastBlock] = -1
    
    firstSpace = diskMap.firstIndex(of: -1)!
    lastBlock = diskMap.lastIndex(where: {x in x > -1})!
}
*/
// task 2
repeat {
    let lastUsedBlockIndex = diskMap.lastIndex(where: {x in x == currentBlock})!
    let firstUsedBlockIndex = diskMap.firstIndex(where: {x in x == currentBlock})!
    let numberOfBlocks: Int = lastUsedBlockIndex - firstUsedBlockIndex
    
    // look for an empty space of length 'numberOfBlocks'
    var firstEmptyBlockIndex: Int = diskMap.firstIndex(where: {x in x == -1}) ?? -1;
    while(firstEmptyBlockIndex != -1)
    {
        // find the length of the space
        var lastEmptyBlockIndex = firstEmptyBlockIndex
        while(diskMap[lastEmptyBlockIndex] == -1) { lastEmptyBlockIndex += 1 }
        lastEmptyBlockIndex -= 1
        
        if(lastEmptyBlockIndex-firstEmptyBlockIndex > numberOfBlocks)
        {
            // move it
            var teIndex = firstEmptyBlockIndex
            var tbIndex = firstUsedBlockIndex
            var blockCount = numberOfBlocks
            while(blockCount > 0) {
                diskMap[teIndex] = currentBlock
                diskMap[tbIndex] = -1
                blockCount -= 1
                teIndex += 1
                tbIndex += 1
            }
            
            // leave the cycle
            firstEmptyBlockIndex = -1
        }
        else {
            lastEmptyBlockIndex = lastEmptyBlockIndex+1
            // find next empty space
            firstEmptyBlockIndex = (diskMap[lastEmptyBlockIndex...]).firstIndex(where: {x in x == -1}) ?? -1
        }
    }
    // process next block
    currentBlock -= 1
} while (currentBlock >= 0)

// dump the file
do {
    var builder = ""
    
    diskMap.forEach( { cell in
        if(cell == -1) {
            builder += "."
        } else {
            builder += String(cell)
        }
    })
    try builder.write(toFile: finalOutputURL.path, atomically: true, encoding: .ascii)
} catch let error {
    // handle error
    print("Error on writing strings to file: \(error)")
}
// calculate sum
var sum: Int = 0
for (index, value) in diskMap.enumerated() {
    if value > -1 {
        sum += index * value
    }
}

print(sum)
