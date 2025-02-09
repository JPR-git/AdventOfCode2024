func HandleRegion1X(_ garden: inout [[Character]]) -> Int {
    var price: Int = 0
    for (lineIndex, line) in garden.enumerated() {
        for (columnIndex, cell) in line.enumerated() {
            if (columnIndex > 0 && garden[lineIndex][columnIndex-1] != cell) &&
                (columnIndex < garden[lineIndex].count - 1 && garden[lineIndex][columnIndex+1] != cell) &&
                (lineIndex > 0 && garden[lineIndex-1][columnIndex] != cell) &&
                (lineIndex < garden[lineIndex].count - 1 && garden[lineIndex+1][columnIndex] != cell)
            {
                price += 4
                garden[lineIndex][columnIndex] = Character(" ")
            }
        }
   }
    return price
}

func HandleRegion2X(_ garden: inout [[Character]]) -> Int {
    var price: Int = 0
    for (lineIndex, line) in garden.enumerated() {
        for (columnIndex, cell) in line.enumerated() {
            // Xx
            if (columnIndex > 0 && garden[lineIndex][columnIndex-1] != cell) &&
                (columnIndex < garden[lineIndex].count - 2 && garden[lineIndex][columnIndex+1] == cell) &&
                (lineIndex > 0 && garden[lineIndex-1][columnIndex] != cell) &&
                (lineIndex < garden[lineIndex].count - 1 && garden[lineIndex+1][columnIndex] != cell) &&
                
                (columnIndex < garden[lineIndex].count - 1 && garden[lineIndex][columnIndex+1+1] != cell) &&
                (lineIndex > 0 && garden[lineIndex-1][columnIndex+1] != cell) &&
                (lineIndex < garden[lineIndex].count - 1 && garden[lineIndex+1][columnIndex+1] != cell)
            {
                price += 6
                garden[lineIndex][columnIndex] = Character(" ")
                garden[lineIndex][columnIndex+1] = Character(" ")
            }
        }
   }
    return price
}

