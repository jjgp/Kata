import XCTest
@testable import LeetCode

final class LRUCacheTests: XCTestCase {
    func testLRUCache() {
        let cache =  LRUCache(2)
        cache.put(2, 1)
        cache.put(3, 2)
        XCTAssertEqual(cache.get(3), 2)
        XCTAssertEqual(cache.get(2), 1)
        cache.put(4, 3)
        XCTAssertEqual(cache.get(2), 1)
        XCTAssertEqual(cache.get(3), -1)
        XCTAssertEqual(cache.get(4), 3)
    }
}
