//
//  BinaryWriter.swift
//  SwityBytes
//
//  Created by Quentin Berry on 2/7/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import Foundation

public class BinaryWriter{
    public var data: BinaryData
    private(set) var writeIndex: Int = 0
    private(set) var writeBitIndex: Int = 0
    
    public init(data: [UInt8]) {
        self.data = BinaryData(data: data)
    }
    
    public init(data: Data) {
        self.data = BinaryData(data: [UInt8](data))
    }
    
    public init() {
        self.data = BinaryData()
    }
    
    // MARK: - WRITE
    
    public func writeUInt8(_ uint: UInt8) throws -> Bool {
        data.bytes.append(contentsOf: [uint])
        writeIndex += MemoryLayout<UInt8>.size
        return true
    }
    
    public func writeUInt16(_ uint: UInt16, bigEndian: Bool? = false) throws -> Bool {
        if bigEndian ?? false{
            let uintBytes = uint.bigEndian.data
            data.bytes.append(contentsOf: uintBytes)
        }else{
            let uintBytes = uint.data
            data.bytes.append(contentsOf: uintBytes)
        }
        writeIndex += MemoryLayout<UInt16>.size
        return true
    }
    
    public func writeUInt32(_ uint: UInt32, bigEndian: Bool? = false) throws -> Bool {
        if bigEndian ?? false{
            let uintBytes = uint.bigEndian.data
            data.bytes.append(contentsOf: uintBytes)
        }else{
            let uintBytes = uint.data
            data.bytes.append(contentsOf: uintBytes)
        }
        writeIndex += MemoryLayout<UInt32>.size
        return true
    }
    
    public func writeUInt64(_ uint: UInt64, bigEndian: Bool? = false) throws -> Bool {
        if bigEndian ?? false{
            let uintBytes = uint.bigEndian.data
            data.bytes.append(contentsOf: uintBytes)
        }else{
            let uintBytes = uint.data
            data.bytes.append(contentsOf: uintBytes)
        }
        writeIndex += MemoryLayout<UInt64>.size
        return true
    }
    
    public func writeInt8(_ int: Int8) throws -> Bool {
        let intBytes = int.data
        data.bytes.append(contentsOf: intBytes)
        writeIndex += MemoryLayout<Int8>.size
        return true
    }
    
    public func writeInt16(_ int: Int16, bigEndian: Bool? = false) throws -> Bool {
        if bigEndian ?? false{
            let intBytes = int.bigEndian.data
            data.bytes.append(contentsOf: intBytes)
        }else{
            let intBytes = int.data
            data.bytes.append(contentsOf: intBytes)
        }
        writeIndex += MemoryLayout<Int16>.size
        return true
    }
    
    public func writeInt32(_ int: Int32, bigEndian: Bool? = false) throws -> Bool {
        if bigEndian ?? false{
            let intBytes = int.bigEndian.data
            data.bytes.append(contentsOf: intBytes)
        }else{
            let intBytes = int.data
            data.bytes.append(contentsOf: intBytes)
        }
        writeIndex += MemoryLayout<Int32>.size
        return true
    }
    
    public func writeInt64(_ int: Int64, bigEndian: Bool? = false) throws -> Bool {
        if bigEndian ?? false{
            let intBytes = int.bigEndian.data
            data.bytes.append(contentsOf: intBytes)
        }else{
            let intBytes = int.data
            data.bytes.append(contentsOf: intBytes)
        }
        writeIndex += MemoryLayout<Int64>.size
        return true
    }
    
    public func writeFloat32(_ float32: Float32, bigEndian: Bool? = false) throws -> Bool {
        if bigEndian ?? false{
            let floatBytes = UInt32(littleEndian: fromByteArray([UInt8](float32.data), UInt32.self)).bigEndian.data
            data.bytes.append(contentsOf: floatBytes)
        }else{
            let floatBytes = float32.data
            data.bytes.append(contentsOf: floatBytes)
        }
        writeIndex += MemoryLayout<Float32>.size
        return true
    }
    
    public func writeFloat64(_ float64: Float64, bigEndian: Bool? = false) throws -> Bool {
        if bigEndian ?? false{
            let floatBytes = UInt64(littleEndian: fromByteArray([UInt8](float64.data), UInt64.self)).bigEndian.data
            data.bytes.append(contentsOf: floatBytes)
        }else{
            let floatBytes = float64.data
            data.bytes.append(contentsOf: floatBytes)
        }
        writeIndex += MemoryLayout<Float64>.size
        return true
    }
    
    public func writeDouble(_ double: Double, bigEndian: Bool? = false) throws -> Bool {
        let _ = try writeFloat64(double, bigEndian: bigEndian)
        return true
    }
    
    public func writeString(_ string: String, encoding: String.Encoding) throws -> Bool {
        let stringBytes = string.data(using: encoding)
        if let dataBytes = stringBytes{
            data.bytes.append(contentsOf: dataBytes)
            writeIndex += dataBytes.count
            return true
        }else{
            throw SwiftyBytesError.StringConversionError
        }
    }
    
    public func writeBool(_ bool: Bool) throws -> Bool {
        if bool{
            let _ = try self.writeUInt8(1)
        }else{
            let _ = try self.writeUInt8(0)
        }
        writeIndex += MemoryLayout<Bool>.size
        return true
    }
    
    public func writeNullTerminatedString(_ string: String, encoding: String.Encoding) throws -> Bool {
        let stringBytes = string.nullTerminated(using: encoding)
        if let dataBytes = stringBytes{
            data.bytes.append(contentsOf: dataBytes)
            writeIndex += dataBytes.count + 1
            return true
        }else{
            throw SwiftyBytesError.StringConversionError
        }
    }
    
    public func write7BitEncodedString(_ string: String, encoding: String.Encoding) throws -> Bool {
        let stringLength = string.count
        Write7BitEncodedInt(Int32(stringLength))
        let stringBytes = string.data(using: encoding)
        if let dataBytes = stringBytes{
            data.bytes.append(contentsOf: dataBytes)
            writeIndex += dataBytes.count
            return true
        }else{
            throw SwiftyBytesError.StringConversionError
        }
    }
    
    public func write(_ bytes: [UInt8]) throws -> Bool {
        data.bytes.append(contentsOf: bytes)
        writeIndex = writeIndex + bytes.count
        return true
    }
    
    public func writeBit(_ on: Bool, _ bitOffset: Int) throws -> Bool{
        if bitOffset > 7 { throw SwiftyBytesError.EndofDataError }
        guard var byte = data.bytes.last else {
            throw SwiftyBytesError.ArraySizeError
        }
        
        if (on) {
            byte = (UInt8)(byte | (1 << bitOffset))
        } else {
            byte = (UInt8)(byte & ~(1 << bitOffset))
        }
        
        data.bytes[writeIndex - 1] = byte
        return true
    }
    
    private func Write7BitEncodedInt(_ value: Int32)
    {
        var num: Int32 = value
        while (num >= 0x80)
        {
            data.bytes += [UInt8(num | 0x80)]
            num = num >> 7
        }
        data.bytes += [UInt8(num)]
    }
}
