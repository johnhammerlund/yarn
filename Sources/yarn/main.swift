//
//  main.swift
//  main
//
//  Created by John Hammerlund on 8/30/18.
//  Copyright © 2018 John Hammerlund. All rights reserved.
//

import Foundation

guard CommandLine.arguments.count == 2 else {
    fatalError("A path to a single property list must be provided")
}

let plist = CommandLine.arguments[1]

let dictionary = NSDictionary(contentsOfFile: plist)
guard let keys = dictionary as? [String: String] else {
    fatalError("Malformatted property list")
}

let secrets = keys.map { kvp -> MaskedSecret in

    guard let data = kvp.value.data(using: .utf8) else {
        fatalError("\(kvp.key): Failed to parse value")
    }
    return DataMasker.mask(key: kvp.key, data: data)
}

let fileGenerator = SwiftSecretsFileGenerator()
print(fileGenerator.generate(secrets: secrets))
