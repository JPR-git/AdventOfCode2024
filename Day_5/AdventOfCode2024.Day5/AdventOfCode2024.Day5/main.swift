import Foundation
import System

var rules: [[Int]] = []
var pages: [[Int]] = []

let fileURL = FileManager.default.homeDirectoryForCurrentUser.appending(path: "source/AdventOfCode2024/Day_5/AoC2024_input.5.1")

let ruleRegex = try Regex("([0-9]{2})\\|([0-9]{2})", as: (Substring, Substring, Substring).self)

for try await line in fileURL.lines {
    if line.isEmpty {
        continue
    }
    
    line.matches(of: ruleRegex).forEach( {match in
        //print(match.output)
        rules.append([(Int(match.output.1) ?? 0), (Int(match.output.2) ?? 0)])
    })
}
let _ = print("Rules #: " + String(rules.count))

let fileURL2 = FileManager.default.homeDirectoryForCurrentUser.appending(path: "source/AdventOfCode2024/Day_5/AoC2024_input.5.2")
for try await line in fileURL2.lines {
    if line.isEmpty {
        continue
    }
    
    var numbers: [Int] = []
    line.components(separatedBy: ",").forEach({ number in
        numbers.append(Int(number) ?? 0 )
    })
    pages.append(numbers)
}
let _ = print("Pages #: " + String(pages.count))

var middle: Int = 0

var valid: Bool? = nil
var invalidRowIndex: [Int] = []
for (pageIndex, line) in pages.enumerated()
{
    valid = nil
    for (_, rule) in rules.enumerated()
    {
        if line.contains(rule[0]) {
            let i1:Int = line.firstIndex(of: rule[0]) ?? -1
            let i2:Int = line.firstIndex(of: rule[1]) ?? -1
            
            if i1 == i2 || i1 == -1 || i2 == -1 {
                continue
            }
            
            if(i1  < i2) {
                if valid == nil {
                    valid = true
                }
            }
            
            if(i1  > i2) {
                if !(invalidRowIndex.count > 0 && invalidRowIndex[invalidRowIndex.count-1] == pageIndex) {
                    invalidRowIndex.append(pageIndex)
                }
                valid = false
            }
        }
    }
    
    if valid ?? false {
        middle += line[Int((line.count-1)/2)]
    }
}
let _ = print("Middle sum #: " + String(middle))

let _ = print("Invalid rows #: " + String(invalidRowIndex.count))
var middle2: Int = 0
invalidRowIndex.forEach({ index in
    //let _ = print("Processing: " + String(index))
    var pageLine = pages[index]
    var valid: Bool = true
    repeat {
        valid = true
        for (_, rule) in rules.enumerated()
        {
            if pageLine.contains(rule[0]) {
                let i1:Int = pageLine.firstIndex(of: rule[0]) ?? -1
                let i2:Int = pageLine.firstIndex(of: rule[1]) ?? -1
                
                if i1 == i2 || i1 == -1 || i2 == -1 {
                    continue
                }
                
                if(i1  > i2) {
                    //let _ = print("    Fixing rule: " + String(rindex))
                    let t = pageLine[i1]
                    pageLine[i1] = pageLine[i2]
                    pageLine[i2] = t
                    //print(pageLine)
                    valid = false
                    break
                }
            }
        }
    } while(!valid)
    
    middle2 += pageLine[Int((pageLine.count-1)/2)]
})
let _ = print("Middle sum #: " + String(middle2))
