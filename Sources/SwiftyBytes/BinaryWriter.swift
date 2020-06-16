//
//  BinaryWriter.swift
//  SwityBytes
//
//  Created by Quentin Berry on 2/7/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import Foundation

public class BinaryWriter{
    public var data: Data
    private(set) var writeIndex: Int = 0
    private(set) var writeBitIndex: Int = 0
    
    public init(data: [UInt8]) {
        let dataFromBytes = Data(data)
        self.data = dataFromBytes
    }
    
    public init(data: Data) {
        self.data = data
    }
    
    public init() {
        self.data = Data()
    }
    
    public func writeUInt8(_ uint: UInt8) throws -> Bool {
        data.append(contentsOf: [uint])
        writeIndex = writeIndex + MemoryLayout<UInt8>.size
        return true
    }
    
    public func writeUInt16(_ uint: UInt16) throws -> Bool {
        let uintBytes = uint.data
        data.append(contentsOf: uintBytes)
        writeIndex = writeIndex + MemoryLayout<UInt16>.size
        return true
    }
    
    public func writeUInt32(_ uint: UInt32) throws -> Bool {
        let uintBytes = uint.data
        data.append(contentsOf: uintBytes)
        writeIndex = writeIndex + MemoryLayout<UInt32>.size
        return true
    }
    
    public func writeUInt64(_ uint: UInt64) throws -> Bool {
        let uintBytes = uint.data
        data.append(contentsOf: uintBytes)
        writeIndex = writeIndex + MemoryLayout<UInt64>.size
        return true
    }
    
    public func writeInt8(_ int: Int8) throws -> Bool {
        let intBytes = int.data
        data.append(contentsOf: intBytes)
        writeIndex = writeIndex + MemoryLayout<Int8>.size
        return true
    }
    
    public func writeInt16(_ int: Int16) throws -> Bool {
        let intBytes = int.data
        data.append(contentsOf: intBytes)
        writeIndex = writeIndex + MemoryLayout<Int16>.size
        return true
    }
    
    public func writeInt32(_ int: Int32) throws -> Bool {
        let intBytes = int.data
        data.append(contentsOf: intBytes)
        writeIndex = writeIndex + MemoryLayout<Int32>.size
        return true
    }
    
    public func writeInt64(_ int: Int64) throws -> Bool {
        let uintBytes = int.data
        data.append(contentsOf: uintBytes)
        writeIndex = writeIndex + MemoryLayout<Int64>.size
        return true
    }
    
    public func writeFloat32(_ float32: Float32) throws -> Bool {
        let floatBytes = float32.data
        data.append(contentsOf: floatBytes)
        writeIndex = writeIndex + MemoryLayout<Float32>.size
        return true
    }
    
    public func writeFloat64(_ float64: Float64) throws -> Bool {
        let floatBytes = float64.data
        data.append(contentsOf: floatBytes)
        writeIndex = writeIndex + MemoryLayout<Float64>.size
        return true
    }
    
    public func writeString(_ string: String, encoding: String.Encoding) throws -> Bool {
        let stringBytes = string.data(using: encoding)
        if let dataBytes = stringBytes{
            data.append(contentsOf: dataBytes)
            writeIndex = writeIndex + dataBytes.count
            return true
        }else{
            throw SwiftyBytesExceptions.StringConversionError
        }
    }
    
    public func writeBool(_ bool: Bool) throws -> Bool {
        if bool{
            let _ = try self.writeUInt8(1)
        }else{
            let _ = try self.writeUInt8(0)
        }
        writeIndex = writeIndex + MemoryLayout<Bool>.size
        return true
    }
    
    public func writeNullTerminatedString(_ string: String, encoding: String.Encoding) throws -> Bool {
        let stringBytes = string.nullTerminated(using: encoding)
        if let dataBytes = stringBytes{
            data.append(contentsOf: dataBytes)
            writeIndex = writeIndex + dataBytes.count + 1
            return true
        }else{
            throw SwiftyBytesExceptions.StringConversionError
        }
    }
    
    public func write7BitEncodedString(_ string: String, encoding: String.Encoding) throws -> Bool {
        let stringLength = string.count
        Write7BitEncodedInt(Int32(stringLength))
        let stringBytes = string.data(using: encoding)
        if let dataBytes = stringBytes{
            data.append(contentsOf: dataBytes)
            writeIndex = writeIndex + dataBytes.count
            return true
        }else{
            throw SwiftyBytesExceptions.StringConversionError
        }
    }
    
    public func write(_ bytes: [UInt8]) throws -> Bool {
        data.append(contentsOf: bytes)
        writeIndex = writeIndex + bytes.count
        return true
    }
    
    public func writeBit(_ on: Bool, _ bitOffset: Int) throws -> Bool{
        if bitOffset > 7 { throw SwiftyBytesExceptions.EndofDataError }
        guard var byte = data.last else {
            throw SwiftyBytesExceptions.ArraySizeError
        }
        
        if (on) {
            byte = (UInt8)(byte | (1 << bitOffset))
        } else {
            byte = (UInt8)(byte & ~(1 << bitOffset))
        }
        
        data[writeIndex - 1] = byte
        return true
    }
    
    private func Write7BitEncodedInt(_ value: Int32)
    {
        var num: Int32 = value
        while (num >= 0x80)
        {
            data += [UInt8(num | 0x80)]
            num = num >> 7
        }
        data += [UInt8(num)]
    }
}
