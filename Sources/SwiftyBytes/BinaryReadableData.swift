//
//  BinaryReadableData.swift
//  SwityBytes
//
//  Created by Quentin Berry on 2/7/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import Foundation

public struct BinaryReadableData{
    public let data: Data
    
    public init(data: [UInt8]) {
        let dataFromBytes = Data(data)
        self.data = dataFromBytes
    }
    
    public init(data: Data) {
        self.data = data
    }

    public func getUInt8(_ offset: Int) throws -> UInt8 {
        guard offset < data.count else { throw SwiftyBytesExceptions.EndofDataError }
        return data[offset]
    }
    
    public func getUInt16(_ offset: Int) throws -> UInt16 {
        guard offset + 1 < data.count else { throw SwiftyBytesExceptions.EndofDataError }
        let end = offset + MemoryLayout<UInt16>.size
        let value: UInt16 = self.data.subdata(in: offset..<end).withUnsafeBytes { $0.load(as: UInt16.self) }
        return value
    }
    
    public func getUInt32(_ offset: Int) throws -> UInt32 {
        guard offset + 3 < data.count else { throw SwiftyBytesExceptions.EndofDataError }
        let end = offset + MemoryLayout<UInt32>.size
        let value: UInt32 = self.data.subdata(in: offset..<end).withUnsafeBytes { $0.load(as: UInt32.self) }
        return value
    }
    
    public func getUInt64(_ offset: Int) throws -> UInt64 {
        guard offset + 7 < data.count else { throw SwiftyBytesExceptions.EndofDataError }
        let end = offset + MemoryLayout<UInt64>.size
        let value: UInt64 = self.data.subdata(in: offset..<end).withUnsafeBytes { $0.load(as: UInt64.self) }
        return value
    }
    
    public func getInt8(_ offset: Int) throws -> Int8 {
        let uint: UInt8 = try getUInt8(offset)
        return Int8(bitPattern: uint)
    }
    
    public func getInt16(_ offset: Int) throws -> Int16 {
        let uint: UInt16 = try getUInt16(offset)
        return Int16(bitPattern: uint)
    }
    
    public func getInt32(_ offset: Int) throws -> Int32 {
        let uint: UInt32 = try getUInt32(offset)
        return Int32(bitPattern: uint)
    }
    
    public func getInt64(_ offset: Int) throws -> Int64 {
        let uint: UInt64 = try getUInt64(offset)
        return Int64(bitPattern: uint)
    }
    
    public func getFloat32(_ offset: Int) throws -> Float32 {
        let uint: UInt32 = try getUInt32(offset)
        return Float32(bitPattern: uint)
    }
    
    public func getFloat64(_ offset: Int) throws -> Float64 {
        let uint: UInt64 = try getUInt64(offset)
        return Float64(bitPattern: uint)
    }
    
    public func getFloat(_ offset: Int) throws -> Float {
        let uint: UInt32 = try getUInt32(offset)
        return Float(bitPattern: uint)
    }
    
    public func getDouble(_ offset: Int) throws -> Double {
        let uint: UInt64 = try getUInt64(offset)
        return Double(bitPattern: uint)
    }
    
    public func getBool(_ offset: Int) throws -> Bool {
        let boolVal = try self.getUInt8(offset)
        switch boolVal{
        case 0:
            return false
        case 1:
            return true
        default:
            throw SwiftyBytesExceptions.IncorrectValueType
        }
    }
    
    public func getNullTerminatedString(_ offset: Int) throws -> String {
        var utf8 = UTF8()
        var string = ""
        var generator = try subData(offset, data.count - offset).data.makeIterator()

        while true {
            switch utf8.decode(&generator) {
            case .scalarValue(let unicodeScalar) where unicodeScalar.value > 0:
                string.append(String(unicodeScalar))
            case .scalarValue(_)://\0 means end of string
                return string
            case .emptyInput:
                throw SwiftyBytesExceptions.StringConversionError
            case .error:
                throw SwiftyBytesExceptions.StringConversionError
            }
        }
    }
    
    public func getNullTerminatedStringTrimmed(_ offset: Int) throws -> String {
        var utf8 = UTF8()
        var string = ""
        var generator = try subData(offset, data.count - offset).data.makeIterator()

        while true {
            switch utf8.decode(&generator) {
            case .scalarValue(let unicodeScalar) where unicodeScalar.value > 0:
                string.append(String(unicodeScalar))
            case .scalarValue(_)://\0 means end of string
                return string.trimmingCharacters(in: .whitespacesAndNewlines)
            case .emptyInput:
                throw SwiftyBytesExceptions.StringConversionError
            case .error:
                throw SwiftyBytesExceptions.StringConversionError
            }
        }
    }
    
    public func getString(_ offset: Int, length: Int) throws -> String {
      var utf8 = UTF8()
      var string = ""
      var generator = try subData(offset, length).data.makeIterator()
      
      while true {
        switch utf8.decode(&generator) {
        case .scalarValue(let unicodeScalar):
          string.append(String(unicodeScalar))
        case .emptyInput:
          return string
        case .error:
          throw SwiftyBytesExceptions.StringConversionError
        }
      }
    }
    
    public func get7BitEncodedString(_ offset: Int) throws -> String {
        let stringLength = try get7BitEncodedInt(offset)
        let bytes = try subData(offset, stringLength + 1).data
      
        return String(bytes: bytes, encoding: .ascii)!
    }
    func get7BitEncodedInt(_ offset: Int) throws -> Int {
        // Read out an Int32 7 bits at a time.  The high bit
        // of the byte when on means to continue reading more bytes.
        var mutatingOffset = offset
        var count: Int = 0
        var shift: Int = 0
        var b: UInt8
        repeat {
            // Check for corruption.  Read a max of 5 bytes.
            if (shift == 5 * 7){  // 5 bytes max per Int32, shift += 7
                throw SwiftyBytesExceptions.EndofDataError
            }

            b = try getUInt8(mutatingOffset)
            count |= Int(b & 0x7F) << shift
            shift += 7
            mutatingOffset += 1
        } while ((b & 0x80) != 0)
        return count
    }
    
    public func subData(_ offset: Int, _ length: Int) throws -> BinaryReadableData {
        if offset >= 0 && offset <= data.count && length >= 0 && (offset + length) <= data.count {
            return BinaryReadableData(data: Array(data[offset..<(offset + length)]))
        } else {
            throw SwiftyBytesExceptions.EndofDataError
        }
    }
    
    public func subData(_ offset: Int, _ length: Int) throws -> [UInt8] {
        if offset >= 0 && offset <= data.count && length >= 0 && (offset + length) <= data.count {
            return Array(data[offset..<(offset + length)])
        } else {
            throw SwiftyBytesExceptions.EndofDataError
        }
    }
}
