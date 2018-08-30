import XCTest
@testable import yarn

final class yarnTests: XCTestCase {

    func testBasicMaskAndUnmask() {
        var mySecret = "hunter2"
        let data = mySecret.data(using: .utf8)!
        let maskedSecret = DataMasker.mask(key: "derp", data: data)
        let unmaskedData = DataMasker.unmask(secret: maskedSecret)

        XCTAssertEqual(data, unmaskedData)
    }

    func testSampleOutput() {
        XCTAssertEqual(Secrets.password, "hunter2")
        XCTAssertEqual(Secrets.awsKey, "23478207027842073230762374023")
        XCTAssertEqual(Secrets.base64Key, "qPOcU+FAScqoYY5XY/oFRylkVcmkHxN1kfepJ80lUfE=")
    }


    static var allTests = [
        ("testBasicMaskAndUnmask", testBasicMaskAndUnmask),
    ]
}
