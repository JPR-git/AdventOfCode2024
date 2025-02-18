import Foundation
import System

let inputFileURL = FileManager.default.homeDirectoryForCurrentUser.appending(
    path: "source/AdventOfCode2024/Day_14/AoC2024_sample.14")
let wide: Int = 11 //101
let tall: Int = 7 //103

// p=9,5 v=-3,-3
let parsedLine = try Regex("^p=([\\-0-9]+),([\\-0-9]+) v=([\\-0-9]+),([\\-0-9]+)$", as: (Substring, Substring, Substring, Substring, Substring).self)

var robots: [Robot] = []
// MAIN
for try await line in inputFileURL.lines {
    let match = line.firstMatch(of: parsedLine)
    
    robots.append(Robot(
        position: (Int(match!.output.1) ?? -1, (Int(match!.output.2) ?? -1)),
        velocity: (Int(match!.output.3) ?? -1, (Int(match!.output.4) ?? -1))))
}
print("Robots: \(robots.count)")

for i in 0..<100 {
    
}
