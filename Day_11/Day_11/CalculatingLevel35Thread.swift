import Foundation
import System

class CalculatingLevel35Thread: Thread {
    let waiter = DispatchGroup()
    
    var index: Int
    var value: Int
    let maxIteration: Int = 35
    var result: Int = 0
    
    init(_ index: Int, _ startValue: Int) {
        self.index = index
        self.value = startValue
    }
    
    override func start() {
        waiter.enter()
        super.start()
    }
    
    func join() {
        waiter.wait()
    }
 
    
    override func main() {
        var line: LinkedList = LinkedList()
        var node: LinkedNode = LinkedNode(value: self.value)
        line.head = node
        
        self.result = Iterate(0, line)
        waiter.leave()
    }
    
    func Iterate(_ iterationStep: Int, _ list: LinkedList) -> Int {
        var sum : Int = 0
        let count = list.count()
        
        if(iterationStep == maxIteration) {
            //print("\(self.index) : \(iterationStep) : \(count)")
            return count
        }
        
        if(count > MaxChunkSize) {
            // split off first chunk and process it
            var node : LinkedNode = list.head!
            var i:Int = 1
            while i < MaxChunkSize { node = node.next!; i += 1; }
            
            var startNode : LinkedNode? = list.head
            list.head = node.next
            node.next = nil
            
            let splittedList: LinkedList = LinkedList()
            splittedList.head = startNode
            
            while startNode != nil {
                startNode = ProcessNode(startNode!)
            }
            
            sum += Iterate(iterationStep + 1, splittedList)
        }
        
        var index:Int = 0
        var node : LinkedNode? = list.head
        
        while node != nil {
            node = ProcessNode(node!)
            index += 1
        }
        
        return sum + Iterate(iterationStep + 1, list)
    }

    func ProcessNode(_ currentNode: LinkedNode)  -> LinkedNode? {
        // 0 -> 1
        if currentNode.value == 0{
            currentNode.value = 1
        }
        // even number of digits -> split into text halfs
        else if (String(currentNode.value).count % 2 == 0) {
            let text = String(currentNode.value)
            let indexOfHalfLeft = text.index(text.startIndex, offsetBy: (Int)(text.count-1)/2)
            let indexOfHalfRight = text.index(text.startIndex, offsetBy: text.count/2)
            
            let leftHalf: String = String(text[...indexOfHalfLeft])
            let rightHalf: String = String(text[indexOfHalfRight...])
            
            // replace the current node value
            currentNode.value = Int(leftHalf)!
            
            // inject the next node with rightHalf value
            let newNode = LinkedNode(value: Int(rightHalf)!)
            if(currentNode.next == nil) {
                currentNode.next = newNode
                return newNode.next
            } else {
                let nextNode = currentNode.next
                
                newNode.next = nextNode
                currentNode.next = newNode
                
                return newNode.next
            }
        }
        // anything else -> *2024
        else {
            currentNode.value = 2024 * currentNode.value
        }
        // move to the next node
        return currentNode.next
    }
}
