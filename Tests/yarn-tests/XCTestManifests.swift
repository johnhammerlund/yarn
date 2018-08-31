import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(DataMaskerTests.allTests),
        testCase(SwiftSecretsFileGeneratorTests.allTests)
    ]
}
#endif
