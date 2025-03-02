struct Reindeer {
    var direction: Int
    var position: (Int,Int)
    
    init(_ direction: Int, _ position: (Int, Int)) {
        self.direction = direction
        self.position = position
    }
}

extension Reindeer {
    func Direction() -> String {
        return switch self.direction {
        case 12: "↑";
        case 6:  "↓";
        case 9:  "←";
        case 3:  "→";
        default: ""
        }
    }
}
