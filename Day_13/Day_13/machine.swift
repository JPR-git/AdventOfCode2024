import Foundation

struct Machine {
    let Prize: (Int,Int)
    let A: (Int,Int)
    let B: (Int,Int)
    var pressA: Int = -1
    var pressB: Int = -1
    
    private init(_ prize: (Int,Int), _ buttonA: (Int,Int), _ buttonB: (Int,Int) ) {
        self.Prize = prize
        self.A = buttonA
        self.B = buttonB
    }
    
    public static func Build(_ lines: [String]) throws -> Machine{
        if(lines.count != 3) {
            throw NSError(domain: "Invalid Input", code: 1001, userInfo: ["line count":lines.count])
        }
     
        let parsedButtonALine = try Regex("^Button A: X\\+([0-9]+), Y\\+([0-9]+)$", as: (Substring, Substring, Substring).self)
        let parsedButtonBLine = try Regex("^Button B: X\\+([0-9]+), Y\\+([0-9]+)$", as: (Substring, Substring, Substring).self)
        let parsedPrizeLine = try Regex("^Prize: X=([0-9]+), Y=([0-9]+)$", as: (Substring, Substring, Substring).self)
        
        var a: (Int, Int) = (-1,-1)
        var b: (Int, Int) = (-1,-1)
        var prize: (Int, Int) = (-1,-1)
        
        for (line) in lines {
            if(line.starts(with: "Button A:")) {
                // ButtonA
                // Button A: X+15, Y+61
                let matchA = line.firstMatch(of: parsedButtonALine)
                a = (Int(matchA!.output.1) ?? -1,Int(matchA!.output.2) ?? -1)
            }
            
            if line.starts(with: "Button B:") {
                // ButtonB
                //Button B: X+66, Y+12
                let matchB = line.firstMatch(of: parsedButtonBLine)
                b = (Int(matchB!.output.1) ?? -1,Int(matchB!.output.2) ?? -1)
            }
            
            if line.starts(with: "Prize:") {
                // Prize
                //Prize: X=1100, Y=4824
                let matchPRIZE = line.firstMatch(of: parsedPrizeLine)
                prize = ((Int(matchPRIZE!.output.1) ?? -1) + 10000000000000,(Int(matchPRIZE!.output.2) ?? -1) + 10000000000000)
            }
        }
        
        if a.0 == -1 || a.1 == -1 ||
            b.0 == -1 || b.1 == -1 ||
            prize.0 == -1 || prize.1 == -1  {
            throw NSError(domain: "Unable to parse Input", code: 1001, userInfo: ["line count":lines.count])
        }
        
        return Machine(prize,a,b)
    }

    mutating func setProcess(_ buttonA: Int, _ buttonB: Int)
    {
        self.pressA = buttonA
        self.pressB = buttonB
    }
}
