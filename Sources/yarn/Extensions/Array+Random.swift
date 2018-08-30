//
//  Array+Random.swift
//  yarn
//
//  Created by John Hammerlund on 8/30/18.
//  Copyright © 2018 John Hammerlund. All rights reserved.
//

import Cocoa

extension Array {

    mutating func popRandom() -> Element {
        let index = Int(arc4random_uniform(UInt32(count)))
        return remove(at: index)
    }

}
