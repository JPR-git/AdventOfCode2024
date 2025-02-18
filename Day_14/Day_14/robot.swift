class Robot {
    // (x,y)
    // x # tiles from the left wall
    // y # tiles from the top wall
    var Position: (Int,Int)
    
    // (x,y)
    // positive x means moving to the right
    // positive y measn moving down
    let Velocity: (Int,Int)
    
    init(position: (Int, Int), velocity: (Int, Int)) {
        self.Position = position
        self.Velocity = velocity
    }
    
    func move(_ wide: Int, _ tall: Int) {
        self.Position.0 += self.Velocity.0
        self.Position.1 += self.Velocity.1
        
        // EVALUATE
        // top
        if self.Position.1 < 0 {
            self.Position.1 = tall + self.Position.1
        }
        // bottom
        if self.Position.1 >= tall {
            self.Position.1 = self.Position.1 - tall
        }
        // left
        if self.Position.0 < 0 {
            self.Position.0 = wide + self.Position.0
        }
        // right
        if self.Position.0 >= wide {
            self.Position.0 = self.Position.0 - wide
        }
    }
    
    func quadrant(_ wide: Int, _ tall: Int) -> Int {
        if self.Position.0 < Int(wide/2) &&
            self.Position.1 < Int(tall/2) {
            return 1
        }
        
        if self.Position.0 > Int(wide/2) &&
            self.Position.1 < Int(tall/2) {
            return 2
        }
        
        if self.Position.0 < Int(wide/2) &&
            self.Position.1 > Int(tall/2) {
            return 3
        }
        
        if self.Position.0 > Int(wide/2) &&
            self.Position.1 > Int(tall/2) {
            return 4
        }
        
        return 0
    }
}
