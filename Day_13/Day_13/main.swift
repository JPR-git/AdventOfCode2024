import Foundation
import System
import simd

let inputFileURL = FileManager.default.homeDirectoryForCurrentUser.appending(
    path: "source/AdventOfCode2024/Day_13/AoC2024_input.13")

var machines: [Machine] = []

// MAIN
var lines: [String] = []
for try await line in inputFileURL.lines {
    if lines.count == 3 {
        do{
            machines.append(try Machine.Build(lines))
            lines = []
            lines.append(line)
        }
        catch {
            print("Unexpected error: \(error).")
        }
    } else {
        lines.append(line)
    }
}
// last block
do{
    machines.append(try Machine.Build(lines))
}
catch {
    print("Unexpected error: \(error).")
}

print("Machines: \(machines.count)")

var prize: Int = 0

for machine in machines {
    let a = simd_double2x2(rows: [
        simd_double2(Double(machine.A.0), Double(machine.B.0)),
        simd_double2(Double(machine.A.1), Double(machine.B.1))
        ])
    
    let b = simd_double2(Double(machine.Prize.0), Double(machine.Prize.1))
    
    let x = simd_mul(a.inverse, b)
    
    let pressButtonA: Int = Int(round(x.x * 1000) / 1000)
    let pressButtonB: Int = Int(round(x.y * 1000) / 1000)
    
    print("A: \(pressButtonA) [\(x.x)], B: \(pressButtonB) [\(x.y)], Tokens:\(3*pressButtonA+pressButtonB)")
    
    if (pressButtonA * machine.A.0 + pressButtonB * machine.B.0) == machine.Prize.0 &&
        ((pressButtonA * machine.A.1 + pressButtonB * machine.B.1) == machine.Prize.1 ) {
        
        //machine.setProcess(pressButtonA, pressButtonB)
        
        prize += (3 * pressButtonA + pressButtonB)
    }
}

print("Prize: \(prize)")
