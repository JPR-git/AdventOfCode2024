import Foundation
import System

let inputFileURL = FileManager.default.homeDirectoryForCurrentUser.appending(
    path: "source/AdventOfCode2024/Day_15/AoC2024_sample.15")

// MAIN
var map: [[Character]] = []
var commands: [Character] = []
for try await line in inputFileURL.lines {
    let lineArray = Array(line)
    if( lineArray[0] == "#") {
        var doubleLine:[Character] = []
        for c in lineArray {
            switch c {
            case "#":
                doubleLine.append(contentsOf: ["#","#"])
            case ".":
                doubleLine.append(contentsOf: [".","."])
            case "O":
                doubleLine.append(contentsOf: ["[","]"])
            case "@":
                doubleLine.append(contentsOf: ["@","."])
            default:
                continue
            }
        }
        map.append(doubleLine)
    } else {
        commands = commands + lineArray
    }
}

var warehouse: Matrix = Matrix(data: map)
print("Warehouse: \(warehouse.rows)x\(warehouse.columns)")
print(warehouse.ToString())

guard var robot = warehouse.locateFirst("@") else {
    print("No robot found!")
    exit(1)
}
print("Robot: (\(robot.0):\(robot.1)) - \(Matrix.ConvertToGPS(robot))")

for movement in commands {
    guard let newRobotCoordinates = warehouse.move(robot, movement) else {
        //print("No movement [\(robot.0),\(robot.1)]")
        continue
    }
    //print("\(movement) [\(newRobotCoordinates.0),\(newRobotCoordinates.1)]")
    robot = newRobotCoordinates
    //print(warehouse.ToString())
}

print(warehouse.ToString())
guard let boxes = warehouse.locate("O") else {
    print("no boxes found.")
    exit(2)
}

var sum: Int = 0
for box in boxes {
    sum += Matrix.ConvertToGPS(box)
}
print("Sum: \(sum)")
print("Game over!")
