struct Shape {
    var blocks: [(Int,Int)]
    let symbol: Character
    
    init(_ symbol: Character, _ firstBlock: (Int,Int)){
        self.blocks = [firstBlock]
        self.symbol = symbol
    }
    
    mutating func add(_ block: (Int,Int)) -> Bool{
        for (_, b) in blocks.enumerated() {
            if b.0 == block.0 && b.1 == block.1 {
                return false
            }
        }
        
        blocks.append(block)
        return true
    }
    
    func calculatePrice() -> Int {
        var price: Int = 0
        for (_, b) in blocks.enumerated() {
            var blockPrice: Int = 4
            if blocks.contains(where: { $0 == ((b.0 - 1),b.1) }) {
                blockPrice -= 1
            }
            if blocks.contains(where: { $0 == ((b.0 + 1),b.1) }) {
                blockPrice -= 1
            }
            if blocks.contains(where: { $0 == (b.0,(b.1 - 1)) }) {
                blockPrice -= 1
            }
            if blocks.contains(where: { $0 == (b.0,(b.1 + 1)) }) {
                blockPrice -= 1
            }
            
            price += blockPrice
        }
        
        return price * blocks.count
    }
    
    static func Detect(_ matrix: Matrix<Character>, _ row: Int, _ column: Int) -> Shape {
        let symbol: Character = matrix[row,column]!
        
        var shape: Shape = Shape(symbol, (row, column))
        
        shape = Sniff(matrix, &shape, row, column)
        
        return shape
    }
    
    private static func Sniff(_ matrix: Matrix<Character>, _ shape: inout Shape, _ blockRow: Int, _ blockColumn: Int) -> Shape {
        var changed: Bool = false
        // NORTH
        if(matrix[blockRow-1,blockColumn] == shape.symbol) {
            changed = shape.add((blockRow-1,blockColumn))
            if(changed) {
                shape = Sniff(matrix, &shape, blockRow-1, blockColumn)
            }
        }
        // SOUTH
        if(matrix[blockRow+1,blockColumn] == shape.symbol) {
            changed = shape.add((blockRow+1,blockColumn))
            if(changed) {
                shape = Sniff(matrix, &shape, blockRow+1, blockColumn)
            }
        }
        // WEST
        if(matrix[blockRow,blockColumn-1] == shape.symbol) {
            changed = shape.add((blockRow,blockColumn-1))
            if(changed) {
                shape = Sniff(matrix, &shape, blockRow, blockColumn-1)
            }
        }
        // EAST
        if(matrix[blockRow,blockColumn+1] == shape.symbol) {
            changed = shape.add((blockRow,blockColumn+1))
            if(changed) {
                shape = Sniff(matrix, &shape, blockRow, blockColumn+1)
            }
        }
        
        return shape
    }
}
