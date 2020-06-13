import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ColorAssetGenTests.allTests),
    ]
}
#endif
