struct Matrix {
    let rows: Int, columns: Int
    
    var grid: [Character]
    
    init( data: [[Character]]) {
        self.rows = data.count
        self.columns = data[0].count
        grid = data.flatMap{$0}
    }
}

extension Matrix {
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Character? {
        get {
            if !indexIsValid(row: row, column: column) {return nil}
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue!
        }
    }
    
    func locateFirst(_ character: Character) -> (Int, Int)? {
        guard let index = grid.firstIndex(of: character)  else {
            return nil
        }
        
        let row = Int(index / columns)
        return (row, index - (row * columns))
    }
    
    func locate(_ character: Character) -> [(Int, Int)]? {
        guard var index = grid.firstIndex(of: character)  else {
            return nil
        }
        
        var result:[(Int, Int)] = []
        
        for el in self.grid.indices(of: character).ranges.enumerated() {
            for i in el.element{
                let row = Int(i / columns)
                result.append((row, i - (row * columns)))
            }
        }
        
        return result
    }
    
    public static func ConvertToGPS(_ coordinates: (Int,Int)) -> Int {
        return coordinates.0 * 100 + coordinates.1
    }
    
    mutating func move(_ what: (Int,Int),_ moveWhere: Character) -> (Int, Int)? {
        switch moveWhere {
        case ">":
            switch self[what.0, what.1 + 1] {
            case "#":
                return nil
            case ".":
                self[what.0, what.1 + 1] = self[what.0, what.1]
                self[what.0, what.1] = "."
                return (what.0, what.1 + 1)
            case "]":
                fallthrough
            case "[":
                guard let moveBox = move((what.0, what.1 + 1), moveWhere) else {return nil}
                self[what.0, what.1 + 1] = self[what.0, what.1]
                self[what.0, what.1] = "."
                return (what.0, what.1 + 1)
            default: return nil
            }
        case "<":
            switch self[what.0, what.1 - 1] {
            case "#":
                return nil
            case ".":
                self[what.0, what.1 - 1] = self[what.0, what.1]
                self[what.0, what.1] = "."
                return (what.0, what.1 - 1)
            case "[":
                fallthrough
            case "]":
                guard let moveBox = move((what.0, what.1 - 1), moveWhere) else {return nil}
                self[what.0, what.1 - 1] = self[what.0, what.1]
                self[what.0, what.1] = "."
                return (what.0, what.1 - 1)
            default: return nil
            }
        case "^":
            switch self[what.0 - 1, what.1] {
            case "#":
                return nil
            case ".":
                self[what.0 - 1, what.1] = self[what.0, what.1]
                self[what.0, what.1] = "."
                return (what.0 - 1, what.1)
            case "[":
                guard let moveLBox = move((what.0 - 1, what.1), moveWhere) else {return nil}
                guard let moveRBox = move((what.0 - 1, what.1 + 1), moveWhere) else {return nil}
                
                self[what.0 - 1, what.1] = self[what.0, what.1]
                self[what.0, what.1] = "."
                // move the ] if moving boxes
                return (what.0 - 1, what.1)
            default: return nil
            }
        case "v":
            switch self[what.0 + 1, what.1] {
            case "#":
                return nil
            case ".":
                self[what.0 + 1, what.1] = self[what.0, what.1]
                self[what.0, what.1] = "."
                return (what.0 + 1, what.1)
            case "O":
                guard let moveBox = move((what.0 + 1, what.1), moveWhere) else {return nil}
                self[what.0 + 1, what.1] = self[what.0, what.1]
                self[what.0, what.1] = "."
                return (what.0 + 1, what.1)
            default: return nil
            }
        default: return nil
        }
    }
    
    
    public  func ToString() -> String {
        var result: String = ""
        
        for row in 0..<rows {
            for column in 0..<columns {
                result += String(self[row,column]!)
            }
            result += "\n"
        }
        return result
    }
}
