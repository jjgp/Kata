import XCTest
@testable import CtCI

final class FibanocciTests: XCTestCase {
    func testBottomUpApproach() {
        XCTAssertEqual(Fibanocci().bottomUpApproach(15), 610)
    }
    
    func testTopDownApproach() {
        XCTAssertEqual(Fibanocci().topDownApproach(15), 610)
    }
}

final class TripleStepTests: XCTestCase {
    func testBottomUpApproach() {
        XCTAssertEqual(TripleStep().bottomUpApproach(4), 7)
    }
    
    func testTopDownApproach() {
        XCTAssertEqual(TripleStep().topDownApproach(4), 7)
    }
}
