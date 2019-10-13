import Foundation

class LRUCache {
    class Node {
        let key: Int
        var next: Node? = nil
        var previous: Node? = nil
        var value: Int
        
        init(key: Int, value: Int) {
            self.key = key
            self.value = value
        }
    }
    
    class DoublyLinkedList {
        private var head: Node? = nil
        private var tail: Node? = nil
        
        func pop() -> Node? {
            let popped = tail
            popped?.previous?.next = nil
            tail = popped?.previous
            popped?.previous = nil
            return popped
        }
        
        func push(_ node: Node) {
            node.next = head
            head?.previous = node
            head = node
            if tail == nil {
                tail = head
            }
        }
        
        func remove(_ node: Node) {
            node.next?.previous = node.previous
            node.previous?.next = node.next
            if node === head {
                head = node.next
            }
            if node === tail {
                tail = node.previous
            }
            node.next = nil
            node.previous = nil
        }
    }
    
    let capacity: Int
    private let list = DoublyLinkedList()
    private var cache = [Int: Node]()
    
    init(_ capacity: Int) {
        self.capacity = capacity
    }
    
    func get(_ key: Int) -> Int {
        if let node = cache[key] {
            list.remove(node)
            list.push(node)
            return node.value
        } else {
            return -1
        }
    }
    
    func put(_ key: Int, _ value: Int) {
        if let cached = cache[key] {
            list.remove(cached)
            list.push(cached)
            cached.value = value
            return
        }
        
        let node = Node(key: key, value: value)
        cache[key] = node
        if cache.count > capacity {
            let popped = list.pop()!
            cache[popped.key] = nil
        }
        list.push(node)
    }
}
