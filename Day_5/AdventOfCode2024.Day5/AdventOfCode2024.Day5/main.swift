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
var middle2: Int = 0
var valid: Bool? = nil
var exchange: [[Int]] = []
pages.forEach({ line in
    valid = nil
    exchange = []
    rules.forEach({rule in
        if line.contains(rule[0]) {
            let i1:Int = line.firstIndex(of: rule[0]) ?? -1
            let i2:Int = line.firstIndex(of: rule[1]) ?? -1
            
            if i1 == i2 || i1 == -1 || i2 == -1 {
                return
            }
            
            if(i1  < i2) {
                if valid == nil {
                    valid = true
                }
            }
            
            if(i1  > i2) {
                exchange.append([i1,i2])
                valid = false
            }
        }
    })
    
    if valid ?? false {
        middle += line[Int((line.count-1)/2)]
    } else if valid != nil {
        var line2 = line
        exchange.forEach({ touple in
            let t = line2[touple[0]]
            line2[touple[0]] = line2[touple[1]]
            line2[touple[1]] = t
        })
        middle2 += line2[Int((line2.count-1)/2)]
    }
})
let _ = print("Middle sum #: " + String(middle))
let _ = print("Middle fixed sum #: " + String(middle2))

