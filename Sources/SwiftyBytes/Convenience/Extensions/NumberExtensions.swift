//
//  NumberExtensions.swift
//  SwityBytes
//
//  Created by Quentin Berry on 2/7/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import Foundation

extension Int {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<Int>.size)
    }
}

extension Int8 {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<Int8>.size)
    }
}

extension Int16 {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<Int16>.size)
    }
}

extension Int32 {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<Int32>.size)
    }
}

extension Int64 {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<Int64>.size)
    }
}

extension UInt8 {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<UInt8>.size)
    }
    var bits: [UInt8] {
        var result : [UInt8] = []
        var _ = UInt8(0b10000000)
        for i in 0..<8 {
            result.append((self >> i) & 1)
        }
        return result
    }
}

extension UInt16 {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<UInt16>.size)
    }
}

extension UInt32 {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<UInt32>.size)
    }
    
    var byteArrayLittleEndian: [UInt8] {
        return [
            UInt8((self & 0xFF000000) >> 24),
            UInt8((self & 0x00FF0000) >> 16),
            UInt8((self & 0x0000FF00) >> 8),
            UInt8(self & 0x000000FF)
        ]
    }
}

extension UInt64 {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<UInt64>.size)
    }
}

extension Float32 {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<Float32>.size)
    }
}

extension Float64 {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<Float64>.size)
    }
}
