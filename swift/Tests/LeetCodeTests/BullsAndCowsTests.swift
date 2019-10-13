import XCTest
@testable import LeetCode

final class BullsAndCowsTests: XCTestCase {
    func testGetHint() {
        XCTAssertEqual(BullsAndCows().getHint("1807", "7810"), "1A3B")
    }
}
