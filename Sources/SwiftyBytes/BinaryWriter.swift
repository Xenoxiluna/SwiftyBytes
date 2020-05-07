//
//  BinaryWriter.swift
//  SwityBytes
//
//  Created by Quentin Berry on 2/7/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import Foundation

class BinaryWriteer {
    public var writeIndex: Int
    var data: BinaryWritableData
  
    public init(_ data: BinaryWritableData, writeIndex: Int = 0) {
        self.data = data
        self.writeIndex = writeIndex
    }
  
    public init() {
        self.data = BinaryWritableData()
        self.writeIndex = 0
    }
    
    func writeUInt8(_ uint: UInt8) throws -> Bool {
        let value: Bool = try data.writeUInt8(uint)
        writeIndex = writeIndex + MemoryLayout<UInt8>.size
        return value
    }
  
    func writeInt8(_ int: Int8) throws -> Bool {
        let value: Bool = try data.writeInt8(int)
        writeIndex = writeIndex + MemoryLayout<Int8>.size
        return value
    }
  
    func writeUInt16(_ uint: UInt16) throws -> Bool {
        let value: Bool = try data.writeUInt16(uint)
        writeIndex = writeIndex + MemoryLayout<UInt16>.size
        return value
    }
  
    func writeInt16(_ int: Int16) throws -> Bool {
        let value: Bool = try data.writeInt16(int)
        writeIndex = writeIndex + MemoryLayout<Int16>.size
        return value
    }
  
    func writeUInt32(_ uint: UInt32) throws -> Bool {
        let value: Bool = try data.writeUInt32(uint)
        writeIndex = writeIndex + MemoryLayout<UInt32>.size
        return value
    }

    func writeInt32(_ int: Int32) throws -> Bool {
        let value: Bool = try data.writeInt32(int)
        writeIndex = writeIndex + MemoryLayout<Int32>.size
        return value
    }

    func writeUInt64(_ uint: UInt64) throws -> Bool {
        let value: Bool = try data.writeUInt64(uint)
        writeIndex = writeIndex + MemoryLayout<UInt64>.size
        return value
    }

    func writeInt64(_ int: Int64) throws -> Bool {
        let value: Bool = try data.writeInt64(int)
        writeIndex = writeIndex + MemoryLayout<Int64>.size
        return value
    }

    func writeFloat32(_ float: Float32) throws -> Bool {
        let value: Bool = try data.writeFloat32(float)
        writeIndex = writeIndex + MemoryLayout<Float32>.size
        return value
    }

    func writeFloat64(_ float: Float64) throws -> Bool {
        let value: Bool = try data.writeFloat64(float)
        writeIndex = writeIndex + MemoryLayout<Float64>.size
        return value
    }

    func writeString(_ string: String, encoding: String.Encoding) throws -> Bool {
        let value = try data.writeString(string, encoding: encoding)
        writeIndex = writeIndex + string.utf8.count + 1//Account for \0
        return value
    }

    func write(_ bytes: [UInt8]) throws -> Bool {
        let value = try data.write(bytes)
        writeIndex = writeIndex + bytes.count
        return value
    }
}
