import Foundation
import System

var matice: [[Character]] = []

let fileURL = FileManager.default.homeDirectoryForCurrentUser.appending(path: "source/AdventOfCode2024/Day_4/AoC2024_input.4")

for try await line in fileURL.lines {
    if line.isEmpty {
        continue
    }
    
    let lineArray = Array(line)
    matice.append(lineArray)
}
print("# row: " + String(matice.count))

var total: Int = 0
// X M A S
for (rindex, row) in matice.enumerated() {
    for (cindex, cell) in row.enumerated() {
        if cell == "X" {
            // N
            if rindex>2 {
                if matice[rindex-1][cindex] == "M" {
                    if matice[rindex-2][cindex] == "A" {
                        if matice[rindex-3][cindex] == "S" {
                            total += 1
                        }
                    }
                }
            }
            // NE
            if rindex>2 && (row.count-1-cindex)>2{
                if matice[rindex-1][cindex+1] == "M" {
                    if matice[rindex-2][cindex+2] == "A" {
                        if matice[rindex-3][cindex+3] == "S" {
                            total += 1
                        }
                    }
                }
            }
            // E
            if (row.count-1-cindex)>2{
                if matice[rindex][cindex+1] == "M" {
                    if matice[rindex][cindex+2] == "A" {
                        if matice[rindex][cindex+3] == "S" {
                            total += 1
                        }
                    }
                }
            }
            // SE
            if (matice.count-1-rindex)>2 && (row.count-1-cindex)>2{
                if matice[rindex+1][cindex+1] == "M" {
                    if matice[rindex+2][cindex+2] == "A" {
                        if matice[rindex+3][cindex+3] == "S" {
                            total += 1
                        }
                    }
                }
            }
            // S
            if (matice.count-1-rindex)>2{
                if matice[rindex+1][cindex] == "M" {
                    if matice[rindex+2][cindex] == "A" {
                        if matice[rindex+3][cindex] == "S" {
                            total += 1
                        }
                    }
                }
            }
            // SW
            if (matice.count-1-rindex)>2 && cindex>2{
                if matice[rindex+1][cindex-1] == "M" {
                    if matice[rindex+2][cindex-2] == "A" {
                        if matice[rindex+3][cindex-3] == "S" {
                            total += 1
                        }
                    }
                }
            }
            // W
            if cindex>2{
                if matice[rindex][cindex-1] == "M" {
                    if matice[rindex][cindex-2] == "A" {
                        if matice[rindex][cindex-3] == "S" {
                            total += 1
                        }
                    }
                }
            }
            // NW
            if rindex>2 && cindex>2{
                if matice[rindex-1][cindex-1] == "M" {
                    if matice[rindex-2][cindex-2] == "A" {
                        if matice[rindex-3][cindex-3] == "S" {
                            total += 1
                        }
                    }
                }
            }
        }
    }
}
print("# XMAS: " + String(total))
total=0
for (_, row) in matice.enumerated() {
    for (_, cell) in row.enumerated() {
        if cell == "A" {
            total += 1
        }
    }
}
print(total)

total = 0
// M A S
for (rindex, row) in matice.enumerated() {
    for (cindex, cell) in row.enumerated() {
        if cell == "A" {
            if rindex>0 && matice.count-1-rindex>0
                && cindex>0 &&  (row.count-1-cindex)>0
            {
                if ((matice[rindex-1][cindex-1] == "M"
                     && matice[rindex+1][cindex+1] == "S")
                    || (matice[rindex-1][cindex-1] == "S"
                        && matice[rindex+1][cindex+1] == "M"))
                    && ((matice[rindex+1][cindex-1] == "S"
                         && matice[rindex-1][cindex+1] == "M")
                        || (matice[rindex+1][cindex-1] == "M"
                            && matice[rindex-1][cindex+1] == "S"))
                {
                    total += 1
                }
            }
        }
    }
}
print("# X-MAS: " + String(total))
