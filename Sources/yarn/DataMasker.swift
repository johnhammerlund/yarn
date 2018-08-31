//
//  DataMasker.swift
//  yarn
//
//  Created by John Hammerlund on 8/30/18.
//  Copyright © 2018 John Hammerlund. All rights reserved.
//

import Foundation
import Security

public final class DataMasker {

    public static func mask(key: String, data: Data) -> MaskedSecret {
        let keySpace = 256

        let maskKey = Data.random(length: keySpace)
        var allPositions: [Int] = []
        for i in 0..<keySpace {
            allPositions.append(i)
        }

        var unmaskedData = Data.random(length: keySpace)
        var keyPositions: [Int] = []
        for i in 0..<data.count {
            let position = allPositions.popRandom()
            unmaskedData[position] = data[i]
            keyPositions.append(position)
        }
        let unmaskedBytes = unmaskedData.map { $0 }
        let maskKeyBytes = maskKey.map { $0 }

        let maskedBytes = zip(unmaskedBytes, maskKeyBytes).map(^)
        let maskedData = Data(bytes: maskedBytes)

        return MaskedSecret(name: key, data: maskedData, keySpace: keySpace, maskKey: maskKey, secretPositions: keyPositions)
    }

    public static func unmask(secret: MaskedSecret) -> Data {
        let maskedBytes = secret.data.map { $0 }
        let maskKeyBytes = secret.maskKey.map { $0 }

        let unmaskedBytes = zip(maskedBytes, maskKeyBytes).map(^)

        var data = Data()
        for position in secret.secretPositions {
            data.append(unmaskedBytes[position])
        }
        return data
    }

}
