//
//  Data+Random.swift
//  yarn
//
//  Created by John Hammerlund on 8/31/18.
//

import Foundation
import Security

extension Data {

    static func random(length: Int) -> Data {
        var buffer = [UInt8](repeating: 0, count: length)
        _ = SecRandomCopyBytes(kSecRandomDefault, length, &buffer)
        return Data(bytes: buffer)
    }

}
