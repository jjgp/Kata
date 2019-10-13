class Fibanocci {
    func bottomUpApproach(_ n: Int) -> Int {
        if n == 0 {
            return n
        }
        
        var a = 0
        var b = 1
        for _ in 2..<n {
            let c = a + b
            a = b
            b = c
        }
        return a + b
    }
    
    func topDownApproach(_ n: Int) -> Int {
        var cache = [Int: Int]()
        return topDownApproachMemoized(n, cache: &cache)
    }
    
    func topDownApproachMemoized(_ n: Int, cache: inout [Int: Int]) -> Int {
        if n == 0 || n == 1 {
            return n
        } else if let cached = cache[n] {
            return cached
        }
        
        cache[n] = topDownApproachMemoized(n - 1, cache: &cache) +
            topDownApproachMemoized(n - 2, cache: &cache)
        return cache[n]!
    }
}

class TripleStep {
    func bottomUpApproach(_ n: Int) -> Int {
        if n < 3 {
            return n
        }
        
        var a = 1
        var b = 1
        var c = 2
        for _ in 3..<n {
            let d = a + b + c
            a = b
            b = c
            c = d
        }
        return a + b + c
    }
    
    func topDownApproach(_ n: Int) -> Int {
        var cache = [Int: Int]()
        return topDownApproachMemoized(n, cache: &cache)
    }
    
    func topDownApproachMemoized(_ n: Int, cache: inout [Int: Int]) -> Int {
        if n < 0 {
            return 0
        } else if n == 0 {
            return 1
        } else if let cached = cache[n] {
            return cached
        }
        
        cache[n] = topDownApproachMemoized(n - 1, cache: &cache) +
            topDownApproachMemoized(n - 2, cache: &cache) +
            topDownApproachMemoized(n - 3, cache: &cache)
        return cache[n]!
    }
}
