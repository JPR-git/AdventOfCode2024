struct Matrix {
    let rows: Int, columns: Int
    var grid: [Character]
    init(rows: Int, columns: Int, defaultValue: Character) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: defaultValue, count: rows * columns)
    }
    private init( data: [[Character]]) {
        self.rows = data.count
        self.columns = data[0].count
        grid = data.flatMap{$0}
    }
    
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
    
    public mutating func ToString(_ robots: [Robot], _ robotValue: Character) -> String {
        for robot in robots {
            grid[robot.Position.1 * columns + robot.Position.0] = robotValue
        }
        
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
