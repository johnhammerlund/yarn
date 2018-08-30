import Foundation
import XCTest
@testable import yarn

final class yarnTests: XCTestCase {

    func testBasicMaskAndUnmask() {
        let mySecret = "hunter2"
        let data = mySecret.data(using: .utf8)!
        let maskedSecret = DataMasker.mask(key: "key", data: data)
        let unmaskedData = DataMasker.unmask(secret: maskedSecret)

        XCTAssertEqual(data, unmaskedData)
    }

    static var allTests = [
        ("testBasicMaskAndUnmask", testBasicMaskAndUnmask),
    ]
}
