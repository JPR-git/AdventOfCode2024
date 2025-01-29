import Foundation

class LinkedNode {
    var value: Int
    var next: LinkedNode?
    
    init(value: Int) {
        self.value = value
    }
}

class LinkedList {
    var head: LinkedNode?
    
    func append(_ value: Int) {
        let newNode = LinkedNode(value: value)
        if head == nil {
            head = newNode
        } else {
            var current = head
            while current?.next != nil {
                current = current?.next
            }
            current?.next = newNode
        }
    }
    
    func count() -> Int {
        var counter: Int = 0
        var node: LinkedNode? = head
        while nil != node {
            counter += 1
            node = node!.next
        }
        return counter
    }
}
