import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(bulls_and_cowsTests.allTests),
    ]
}
#endif
