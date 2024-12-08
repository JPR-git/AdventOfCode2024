//
//  main.swift
//  AdventOfCode.Day1
//
//  Created by Jan CZ on 03.12.2024.
//


import Foundation
import System

let fileURL = FileManager.default.homeDirectoryForCurrentUser.appending(path: "source/aoc2024/Day_1/AoC2024_input.csv")

var list1: [Int] = []
var list2: [Int] = []

for try await line in fileURL.lines {
    //print(line);
    if line.isEmpty {
        continue
    }
    
    let stringArray = line.components(separatedBy: CharacterSet.whitespaces) //.decimalDigits.inverted
    list1.append(Int(stringArray.first!)!)
    list2.append(Int(stringArray.last!)!)
}
let _ = print(list1.count)
let _ = print(list2.count)

list1.sort()
list2.sort()

var similarityList: [Int] = []

list1.forEach({cislo in
    var sum: Int = list2.filter({ $0 == cislo }).count
    similarityList.append(cislo * sum)
})
let sum = similarityList.reduce(0, +)
let _ = print(sum)

