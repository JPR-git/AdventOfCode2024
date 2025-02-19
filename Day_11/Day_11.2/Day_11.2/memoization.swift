struct IterationCoordinates {
    var startValue: Int
    var iteration: Int
    
    init(_ startValue: Int, _ iteration: Int) {
        self.startValue = startValue
        self.iteration = iteration
    }
}

extension IterationCoordinates: Hashable {
    static func == (lhs: IterationCoordinates, rhs: IterationCoordinates) -> Bool {
        return lhs.startValue == rhs.startValue && lhs.iteration == rhs.iteration
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(startValue)
        hasher.combine(iteration)
    }
}
