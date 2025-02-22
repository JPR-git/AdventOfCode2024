import Foundation
import System

let inputFileURL = FileManager.default.homeDirectoryForCurrentUser.appending(
    path: "source/AdventOfCode2024/Day_14/AoC2024_input.14")
let wide: Int = 101 //11
let tall: Int = 103 //7

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

for index in 1..<10000 {
    for robot in robots {
        robot.move(wide, tall)
    }
    
    DumpToFile(index,wide, tall, robots)
}

var quadrant1: Int = 0
var quadrant2: Int = 0
var quadrant3: Int = 0
var quadrant4: Int = 0

for robot in robots {
    switch robot.quadrant(wide, tall){
        case 1: quadrant1 += 1
        case 2: quadrant2 += 1
        case 3: quadrant3 += 1
        case 4: quadrant4 += 1
        default: break
    }
}

print("\(quadrant1)\t\(quadrant2)\n\(quadrant3)\t\(quadrant4)\n")

print("Safety: \(quadrant1*quadrant2*quadrant3*quadrant4)")

func DumpToFile(_ index: Int, _ wide: Int, _ tall: Int, _ robots: [Robot] ) {
    var matrix: Matrix = Matrix(rows: tall, columns: wide, defaultValue: " ")
    
    let outFileURL = FileManager.default.homeDirectoryForCurrentUser.appending(
        path: "source/AdventOfCode2024/Day_14/out/\(index).txt")
    
    do {
        let s: String =  matrix.ToString(robots,"*")
        if s.contains("*******") {
            print(index)
            try s.write(to: outFileURL, atomically: true, encoding: String.Encoding.ascii)
        }
    } catch {
        // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
        print("Failure to write file.")
    }
    
}
