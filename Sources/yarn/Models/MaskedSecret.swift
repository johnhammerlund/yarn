//
//  MaskedSecret.swift
//  yarn
//
//  Created by John Hammerlund on 8/30/18.
//  Copyright © 2018 John Hammerlund. All rights reserved.
//

import Foundation

struct MaskedSecret {

    let name: String
    let data: Data
    let keySpace: Int
    let maskKey: Data
    let secretPositions: [Int]

}
