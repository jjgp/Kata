import XCTest
@testable import leetcode

final class BullsAndCowsTests: XCTestCase {
    func testGetHint() {
        XCTAssertEqual(BullsAndCows().getHint("1807", "7810"), "1A3B")
    }
    
    static var allTests = [
        ("testGetHint", testGetHint)
    ]
}
