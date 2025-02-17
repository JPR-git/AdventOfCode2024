import Foundation

struct Machine {
    let Prize: (Int,Int)
    let A: (Int,Int)
    let B: (Int,Int)
    
    init(_ lines: [String]) throws {
        if(lines.count != 3) {
            throw NSError(domain: "Invalid Input", code: 1001, userInfo: ["line count":lines.count])
        }
     
        let parsedButtonALine = try Regex("^Button A: X\\+([0-9]+), Y\\+([0-9]+)$", as: (Substring, Substring, Substring).self)
        let parsedButtonBLine = try Regex("^Button B: X\\+([0-9]+), Y\\+([0-9]+)$", as: (Substring, Substring, Substring).self)
        let parsedPrizeLine = try Regex("^Prize: X=([0-9]+), Y=([0-9]+)$", as: (Substring, Substring, Substring).self)
        // ButtonA
        // Button A: X+15, Y+61
        let matchA = lines[0].firstMatch(of: parsedButtonALine)
        var a: (Int,Int) = (Int(matchA!.output.1) ?? -1,Int(matchA!.output.2) ?? -1)
        // ButtonB
        //Button B: X+66, Y+12
        let matchB = lines[1].firstMatch(of: parsedButtonBLine)
        var b: (Int,Int) = (Int(matchB!.output.1) ?? -1,Int(matchB!.output.2) ?? -1)
        
        // Prize
        //Prize: X=1100, Y=4824
        let matchPRIZE = lines[2].firstMatch(of: parsedPrizeLine)
        var prize: (Int,Int) = (Int(matchPRIZE!.output.1) ?? -1,Int(matchPRIZE!.output.2) ?? -1)
        
        self.init(prize,a,b)
    }
    
    private init(_ prize: (Int,Int), _ buttonA: (Int,Int), _ buttonB: (Int,Int) ) {
        self.Prize = prize
        self.A = buttonA
        self.B = buttonB
    }
}
