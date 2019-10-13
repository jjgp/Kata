import XCTest
@testable import LeetCode

final class TwoSumTests: XCTestCase {
    func testTwoSum() {
        XCTAssertEqual(TwoSum().twoSum([2, 7, 11, 15], 9), [0, 1])
    }
}
