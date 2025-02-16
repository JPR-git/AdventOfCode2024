struct Matrix<T> {
    let rows: Int, columns: Int
    var grid: [T]
    init(rows: Int, columns: Int, defaultValue: T) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: defaultValue, count: rows * columns)
    }
    init( data: [[T]]) {
        self.rows = data.count
        self.columns = data[0].count
        grid = data.flatMap{$0}
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    mutating func clear(Shape shape: Shape, ClearSymbol clearSymbol: T) -> Bool {
        for(_,b) in shape.blocks.enumerated(){
            self[b.0, b.1] = clearSymbol
        }
        return true
    }
    
    subscript(row: Int, column: Int) -> T? {
        get {
            if !indexIsValid(row: row, column: column) {return nil}
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue ?? "" as! T
        }
    }
}
