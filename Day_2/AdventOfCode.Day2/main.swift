import Foundation
import System

let fileURL = FileManager.default.homeDirectoryForCurrentUser.appending(path: "source/aoc2024/Day_2/AoC2024_input.2")

var list: [[Int]] = []

for try await line in fileURL.lines {
    //print(line);
    if line.isEmpty {
        continue
    }
    
    let stringArray = line.components(separatedBy: CharacterSet.whitespaces)
    
    var cisla: [Int] = []
    stringArray.forEach({cisla.append(Int($0)!)})
    
    list.append(cisla)
}
let _ = print(list.count)

var safeCount: Int = 0

list.forEach({ cisla in
    var isAsc = false;
    
    if(cisla.first! == cisla.last!) {
        return
    }
    
    if(cisla.first! < cisla.last!) {
        isAsc = true
    }
    
    var isSafe = true;
    for (index, element) in cisla.enumerated() {
        if(index > 0) {
            let rozdil = element - cisla[index-1]
            if(isAsc)
            {
                if(![1,2,3].contains(rozdil)){
                    isSafe = false
                }
            } else {
                if(![-1,-2,-3].contains(rozdil)){
                    isSafe = false
                }
            }
        }
    }
    if(isSafe) { safeCount = safeCount + 1}
})
let _ = print("# safe reports: " + String(safeCount))

safeCount = 0
var nonSafeCount = 0
list.forEach({ cisla in
    var isAsc = false
    
    if(cisla.first! == cisla.last!) {
        return
    }
    
    if(cisla.first! < cisla.last!) {
        isAsc = true
    }
    
    var isSafe = true;
    var prvniFail: Int = -1
    for (index, element) in cisla.enumerated() {
        if(index > 0) {
            let rozdil = element - cisla[index-1]
            if(isAsc)
            {
                if(![1,2,3].contains(rozdil)){
                    isSafe = false
                    if(prvniFail == -1) { prvniFail = index}
                }
            } else {
                if(![-1,-2,-3].contains(rozdil)){
                    isSafe = false
                    if(prvniFail == -1) { prvniFail = index}
                }
            }
        }
    }
    
    if(prvniFail != -1){
        var removedIndex: Int = cisla.count-1
        
        while removedIndex >= 0 {
            isSafe = true
            var cisla2: [Int] = []
            cisla2.append(contentsOf: cisla)
            cisla2.remove(at: removedIndex)
            
            for (index, element) in cisla2.enumerated() {
                if(index > 0) {
                    let rozdil = element - cisla2[index-1]
                    if(isAsc)
                    {
                        if(![1,2,3].contains(rozdil)){
                            isSafe = false
                        }
                    } else {
                        if(![-1,-2,-3].contains(rozdil)){
                            isSafe = false
                        }
                    }
                }
            }
            if(isSafe) {break}
            removedIndex = removedIndex - 1
        }
    }
    if(isSafe) { safeCount = safeCount + 1}
    else {
        nonSafeCount = nonSafeCount + 1
        //print(cisla)
    }
})
let _ = print("# tolerate safe reports: " + String(safeCount))
let _ = print("# failed reports: " + String(nonSafeCount))
