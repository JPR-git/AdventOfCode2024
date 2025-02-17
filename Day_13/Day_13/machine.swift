import Foundation

struct Machine {
    let Prize: (Int,Int)
    let A: (Int,Int)
    let B: (Int,Int)
    
    init(_ lines: [String]) throws {
        if(lines.count != 3) {
            throw NSError(domain: "Invalid Input", code: 1001, userInfo: ["line count":lines.count])
        }
     
        let parsedButtonALine = try Regex("^Button A: X/+([0-9]+), Y/+([0-9]+)$", as: (Substring, Substring, Substring).self)
        // ButtonA
        // Button A: X+15, Y+61
        let match = lines[0].firstMatch(of: parsedButtonALine)
     
        // ButtonB
        //Button B: X+66, Y+12
        
        // Prize
        //Prize: X=1100, Y=4824
     
        self.init((0,0),(0,0),(0,0))
    }
    
    private init(_ prize: (Int,Int), _ buttonA: (Int,Int), _ buttonB: (Int,Int) ) {
        self.Prize = prize
        self.A = buttonA
        self.B = buttonB
    }
}
