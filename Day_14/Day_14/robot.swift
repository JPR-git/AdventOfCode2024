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
}
