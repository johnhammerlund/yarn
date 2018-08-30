import XCTest
@testable import yarn

final class yarnTests: XCTestCase {

    func testBasicMaskAndUnmask() {
        var mySecret = "hunter2"
        let data = mySecret.data(using: .utf8)!
        let maskedSecret = DataMasker.mask(data: data)
        let unmaskedData = DataMasker.unmask(secret: maskedSecret)

        XCTAssertEqual(data, unmaskedData)
    }


    static var allTests = [
        ("testBasicMaskAndUnmask", testBasicMaskAndUnmask),
    ]
}
