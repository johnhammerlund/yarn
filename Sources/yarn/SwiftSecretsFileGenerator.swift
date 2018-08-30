//
//  SwiftSecretsFileGenerator.swift
//  yarn
//
//  Created by John Hammerlund on 8/30/18.
//  Copyright © 2018 John Hammerlund. All rights reserved.
//

import Foundation

public final class SwiftSecretsFileGenerator: SecretsFileGenerator {

    private let className = "Secrets"

    public init() {}

    public func generate(secrets: [MaskedSecret]) -> String {
        let computedProperties = secrets.map(generateComputedProperty(secret:)).joined(separator: "\n")
        return """
        import Foundation

        class \(className) {
        \(indent(computedProperties, level: 1))
        }
        """
    }

    private func indent(_ text: String, level: Int) -> String {
        let leading = (0..<level).map { _ in "    " }.joined()
        let lines = text.components(separatedBy: "\n")
        return lines.map { leading + $0 }.joined(separator: "\n")
    }

    private func generateComputedProperty(secret: MaskedSecret) -> String {
        let variableName = secret.name
        let maskKeyInitializerInput = secret.maskKey.map { String(format: "0x%02X", $0) }.joined(separator: ", ")
        let maskedDataInitializerInput = secret.data.map { String(format: "0x%02X", $0) }.joined(separator: ", ")
        let secretPositions = secret.secretPositions.map { String($0) }.joined(separator: ", ")
        return """
        static var \(variableName): String = {
            let maskedData = Data([\(maskedDataInitializerInput)])
            let maskKey = Data([\(maskKeyInitializerInput)])
            let maskedBytes = maskedData.map { $0 }
            let maskKeyBytes = maskKey.map { $0 }

            let unmaskedBytes = zip(maskedBytes, maskKeyBytes).map(^)
            let secretPositions = [\(secretPositions)]

            var data = Data()
            for position in secretPositions {
                data.append(unmaskedBytes[position])
            }
            return String(data: data, encoding: .utf8)!
        }()
        """
    }

}
