import Foundation
import System

var room: [[Character]] = []

enum FinishError: Error {
    case LeavingField
    case WrongDirectionValue
}

func CountOfXFields() -> Int {
    var count: Int = 0
    
    room.forEach({line in
        line.forEach({ cell in
            if cell == "X" {
                count += 1
            }
        })
    })
    return count
}

func PositionInFront(_ position: [Int]) throws -> [Int] {
    // north
    if position[2] == 12 {
        if position[0] == 0 {
            // already on top line
            throw FinishError.LeavingField
        }
        return [position[0]-1,position[1],position[2]]
    }
    // east
    if position[2] == 3 {
        if position[1] >=  (room[position[0]].count - 1){
            // already on right side
            throw FinishError.LeavingField
        }
        return [position[0],position[1]+1,position[2]]
    }
    // south
    if position[2] == 6 {
        if position[0] >= (room.count - 1) {
            // already on bottom line
            throw FinishError.LeavingField
        }
        return [position[0]+1,position[1],position[2]]
    }
    // west
    if position[2] == 9 {
        if position[1] <= 0 {
            // already on left side
            throw FinishError.LeavingField
        }
        return [position[0],position[1]-1,position[2]]
    }
    
    throw FinishError.WrongDirectionValue
}
func MoveNorth(_ position: [Int]) -> [Int] { [position[0]-1,position[1], position[2]] }
func MoveEast(_ position: [Int]) -> [Int] { [position[0],position[1]+1, position[2]] }
func MoveSouth(_ position: [Int]) -> [Int] { [position[0]+1,position[1], position[2]] }
func MoveWest(_ position: [Int]) -> [Int] { [position[0],position[1]-1, position[2]] }
func TurnRight(_ position: [Int]) -> [Int] { [position[0],position[1], (position[2] == 12) ? 3 : (position[2] == 3) ? 6 : (position[2] == 6) ? 9 : 12] }
func MarkPosition(_ position: [Int]) -> [Int] {
    room[position[0]][position[1]] = "X"
    return position
}

func EvaluateNextMove(_ position: [Int]) throws -> ([Int]) -> [Int] {
    let positionInFront = try PositionInFront(position)
    
    if room[positionInFront[0]][positionInFront[1]] == "#" {
        return TurnRight
    }
    
    if position[2] == 12 { return MoveNorth }
    if position[2] == 3 { return MoveEast }
    if position[2] == 6 { return MoveSouth }
    if position[2] == 9 { return MoveWest }
    
    throw FinishError.WrongDirectionValue
}

// MAIN
let fileURL = FileManager.default.homeDirectoryForCurrentUser.appending(path: "source/AdventOfCode2024/Day_6/AoC2024_input.6")

for try await line in fileURL.lines {
    if line.isEmpty {
        continue
    }
    
    let lineArray = Array(line)
    room.append(lineArray)
}
print("Room size: " + String(room.count) + " x " + String(room[0].count))

var position: [Int] = [0, 0, 0]
for (lineIndex, line) in room.enumerated() {
    for (cellIndex, cell) in line.enumerated() {
        if cell == "^" {
            position = [lineIndex, cellIndex, 12]
            break
        }
        if cell == ">" {
            position = [lineIndex, cellIndex, 3]
            break
        }
        if cell == "v" {
            position = [lineIndex, cellIndex, 6]
            break
        }
        if cell == "<" {
            position = [lineIndex, cellIndex, 9]
            break
        }
    }
    if position[2] > 0 {
        break
    }
}
print("Guard position: [" + String(position[0]) + "," + String(position[1]) + "] facing: " + String(position[2]))

do {
    repeat {
        let nextMove = try EvaluateNextMove(position)
        position = MarkPosition(nextMove(position))
        //print(position)
    } while(true)
}
catch FinishError.LeavingField{
    print("Game over!")
    let _ = MarkPosition(position)
    
    print("Count: \(CountOfXFields())")
}
catch FinishError.WrongDirectionValue {
    print("BUG")
    print(position)
}
