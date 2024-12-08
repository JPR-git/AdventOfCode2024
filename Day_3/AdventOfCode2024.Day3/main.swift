//
//  main.swift
//  AdventOfCode2024.Day3
//
//  Created by Jan CZ on 05.12.2024.
//
// mul\(([0-9]{1,3}),([0-9]{1,3})\)
import Foundation
import System

let fileURL = FileManager.default.homeDirectoryForCurrentUser.appending(path: "source/aoc2024/Day_3/AoC2024_input.3")

let nasobeni = try Regex("mul\\(([0-9]{1,3}),([0-9]{1,3})\\)", as: (Substring, Substring, Substring).self)

var celkem: Int = 0

for try await line in fileURL.lines {
    //print(line);
    if line.isEmpty {
        continue
    }
    
    line.matches(of: nasobeni).forEach( {match in
        //print(match.output)
        celkem += (Int(match.output.1) ?? 0) * (Int(match.output.2) ?? 0)
    })
}
let _ = print(celkem)

celkem = 0
let enabledMultiplication = try Regex("mul\\(([0-9]{1,3}),([0-9]{1,3})\\)|do\\(\\)|don't\\(\\)", as: (Substring, Optional<Substring>, Optional<Substring>).self)

var process: Bool = true
for try await line in fileURL.lines {
    if line.isEmpty {
        continue
    }
    
    line.matches(of: enabledMultiplication).forEach( {match in
        //print(match.output)
        if(match.output.0.starts(with: "don")) {
            process = false;
        } else if (match.output.0.starts(with: "do(")) {
            process = true;
        } else {
            if(process){
                celkem += (Int(match.output.1 ?? "0") ?? 0) * (Int(match.output.2 ?? "0") ?? 0)
            }
        }
    })
}
let _ = print(celkem)
