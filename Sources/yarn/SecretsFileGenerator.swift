//
//  SecretsFileGenerator.swift
//  yarn
//
//  Created by John Hammerlund on 8/30/18.
//  Copyright © 2018 John Hammerlund. All rights reserved.
//

import Foundation

public protocol SecretsFileGenerator {
    func generate(secrets: [MaskedSecret]) -> String
}
