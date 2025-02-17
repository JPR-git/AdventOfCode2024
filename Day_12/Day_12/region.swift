struct Shape {
    public static let ClearSymbol: Character = Character(" ")
    
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
    
    func calculatePriceAsTask2() -> Int {
        var price: Int = 0
        // WEST
        let westFacingBlocks = self.blocks.filter({ X in
            !(blocks.contains(where: { $0 == (X.0,(X.1 - 1)) }))
        })
        var groups = Dictionary(grouping: westFacingBlocks, by:  {$0.1})
        price += blocks.count * groups.count
        
        // EAST
        let eastFacingBlocks = self.blocks.filter({ X in
            !(blocks.contains(where: { $0 == (X.0,(X.1 + 1)) }))
        })
        groups = Dictionary(grouping: eastFacingBlocks, by:  {$0.1})
        price += blocks.count * groups.count
        
        // NORT
        let northFacingBlocks = self.blocks.filter({ X in
            !(blocks.contains(where: { $0 == ((X.0 - 1), X.1) }))
        })
        groups = Dictionary(grouping: northFacingBlocks, by:  {$0.0})
        price += blocks.count * groups.count
        
        // SOUTH
        let southFacingBlocks = self.blocks.filter({ X in
            !(blocks.contains(where: { $0 == ((X.0 + 1), X.1) }))
        })
        groups = Dictionary(grouping: southFacingBlocks, by:  {$0.0})
        price += blocks.count * groups.count
        
        return price
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
