//
//  SwiftSecretsFileGeneratorTests.swift
//  yarn-tests
//
//  Created by John Hammerlund on 8/31/18.
//

import Foundation
import XCTest
@testable import yarn

final class SwiftSecretsFileGeneratorTests: XCTestCase {

    private func generateStrings(sourceCode: String) throws -> String {
        let executableName = UUID().uuidString
        let filename = "\(executableName).swift"
        let tempDir = NSTemporaryDirectory()
        let filePath = tempDir + filename
        try sourceCode.write(toFile: filePath, atomically: true, encoding: .utf8)

        let swiftcProcess = Process()
        swiftcProcess.currentDirectoryPath = tempDir
        swiftcProcess.launchPath = "/usr/bin/swiftc"
        swiftcProcess.arguments = [filePath]
        swiftcProcess.launch()
        swiftcProcess.waitUntilExit()

        let stringsPipe = Pipe()

        let stringsProcess = Process()
        stringsProcess.launchPath = "/usr/bin/strings"
        stringsProcess.arguments = ["-", tempDir + executableName]
        stringsProcess.standardOutput = stringsPipe
        stringsProcess.launch()
        stringsProcess.waitUntilExit()

        guard let output = String(data: stringsPipe.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) else {
            fatalError("strings command failed")
        }
        return output
    }

    func testMachOSegmentsConcealMaskedKeys() throws {
        let password = "hunter2"
        let data = password.data(using: .utf8)!
        let maskedSecret = DataMasker.mask(key: "key", data: data)

        let fileGenerator = SwiftSecretsFileGenerator()
        let fileContents = fileGenerator.generate(secrets: [maskedSecret])

        let stringsOutput = try generateStrings(sourceCode: fileContents)
        XCTAssertFalse(stringsOutput.contains(password))
    }

    func testMachOSegmentsDontConcealPlainKeys() throws {
        let password = "hunter2"

        let sourceCode = """
class Secrets {
    static var key = "\(password)"
}
"""
        let stringsOutput = try generateStrings(sourceCode: sourceCode)
        XCTAssert(stringsOutput.contains(password))
    }

    static var allTests = [
        ("testMachOSegmentsConcealMaskedKeys", testMachOSegmentsConcealMaskedKeys),
        ("testMachOSegmentsDontConcealPlainKeys", testMachOSegmentsDontConcealPlainKeys),
        ]

}
