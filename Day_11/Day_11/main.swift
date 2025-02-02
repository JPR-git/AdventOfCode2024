import Foundation
import System

let inputFileURL = FileManager.default.homeDirectoryForCurrentUser.appending(
    path: "source/AdventOfCode2024/Day_11/AoC2024_input.11")

var numberLine: LinkedList = LinkedList()

let MaxIterationCount: Int = 75
let MaxChunkSize: Int = 5000000

func Iterate(_ iterationStep: Int, _ list: LinkedList) -> Int {
    var sum : Int = 0
    
    let count = list.count()
    print("\(iterationStep) : \(count)")
    if(iterationStep == MaxIterationCount) {
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
    
    var node : LinkedNode? = list.head
    
    while node != nil {
        node = ProcessNode(node!)
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

// MAIN
let input: String = try String(contentsOf: inputFileURL, encoding: .ascii).trimmingCharacters(in: .whitespacesAndNewlines)
    
input.split(separator: " ").forEach { numberStr in
    numberLine.append(Int(numberStr)!)
}


let sum = Iterate(0, numberLine)
print(sum)
// over  for 25 it is 233050
