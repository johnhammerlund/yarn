//
//  SwiftSecretsFileGenerator.swift
//  yarn
//
//  Created by John Hammerlund on 8/30/18.
//  Copyright © 2018 John Hammerlund. All rights reserved.
//

import Foundation

final class SwiftSecretsFileGenerator: SecretsFileGenerator {

    private let className = "Secrets"

    func generate(secrets: [MaskedSecret]) -> String {
        let computedProperties = secrets.map(generateComputedProperty(secret:)).joined(separator: "\n")
        return """
        class \(className) {
            \(computedProperties)
        }
        """
    }

    private func generateComputedProperty(secret: MaskedSecret) -> String {
        let variableName = secret.name
        let maskKeyInitializerInput = secret.maskKey.map { String(format: "%02X", $0) }.joined(separator: ", ")
        let maskedDataInitializerInput = secret.data.map { String(format: "%02X", $0) }.joined(separator: ", ")
        return """
        static var \(variableName): String = {
            let maskedData = Data([\(maskedDataInitializerInput)])
            let maskKey = Data([\(maskKeyInitializerInput)])
            let maskedBytes = maskedData.map { $0 }
            let maskKeyBytes = maskKey.map { $0 }

            let unmaskedBytes = zip(maskedBytes, maskKeyBytes).map(^)

            var data = Data()
            for position in secret.secretPositions {
                data.append(unmaskedBytes[position])
            }
            return String(data: data, encoding: .utf8)!
        }()
        """
    }

}
