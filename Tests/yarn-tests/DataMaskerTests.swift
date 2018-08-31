import Foundation
import XCTest
@testable import yarn

final class DataMaskerTests: XCTestCase {

    func testMaskedDataDoesntMatchOriginal() {
        for _ in 0..<100 {
            let length = Int(arc4random() % 256)
            let data = Data.random(length: length)
            let maskedSecret = DataMasker.mask(key: "key", data: data)

            XCTAssertNotEqual(data, maskedSecret.data)
        }
    }

    func testUnmaskedDataMatchesOriginal() {
        for _ in 0..<100 {
            let length = Int(arc4random() % 256)
            let data = Data.random(length: length)
            let maskedSecret = DataMasker.mask(key: "key", data: data)
            let unmaskedData = DataMasker.unmask(secret: maskedSecret)

            XCTAssertEqual(data, unmaskedData)
        }
    }

    static var allTests = [
        ("testMaskedDataDoesntMatchOriginal", testMaskedDataDoesntMatchOriginal),
        ("testUnmaskedDataMatchesOriginal", testUnmaskedDataMatchesOriginal),
    ]
}
