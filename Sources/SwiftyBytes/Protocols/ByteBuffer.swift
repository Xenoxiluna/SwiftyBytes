//
//  File.swift
//  
//
//  Created by Quentin Berry on 6/28/20.
//

import Foundation

public protocol ByteBuffer {
    var bytes: [UInt8] { get set }
    var count: Int { get }
}

extension ByteBuffer{
    // MARK: - READ
    public func getUInt8(_ offset: Int) throws -> UInt8 {
        guard offset < bytes.count else { throw SwiftyBytesError.EndofDataError }
        return bytes[offset]
    }
    
    public func getUInt16(_ offset: Int, bigEndian: Bool? = false) throws -> UInt16 {
        guard offset + 1 < bytes.count else { throw SwiftyBytesError.EndofDataError }
        let end = offset + MemoryLayout<UInt16>.size
        if bigEndian ?? false{
            return fromByteArray(Array(bytes[offset..<end]), UInt16.self).bigEndian
        }else{
            return fromByteArray(Array(bytes[offset..<end]), UInt16.self)
        }
    }
    
    public func getUInt32(_ offset: Int, bigEndian: Bool? = false) throws -> UInt32 {
        guard offset + 3 < bytes.count else { throw SwiftyBytesError.EndofDataError }
        let end = offset + MemoryLayout<UInt32>.size
        if bigEndian ?? false{
            return fromByteArray(Array(bytes[offset..<end]), UInt32.self).bigEndian
        }else{
            return fromByteArray(Array(bytes[offset..<end]), UInt32.self)
        }
    }
    
    public func getUInt64(_ offset: Int, bigEndian: Bool? = false) throws -> UInt64 {
        guard offset + 7 < bytes.count else { throw SwiftyBytesError.EndofDataError }
        let end = offset + MemoryLayout<UInt64>.size
        if bigEndian ?? false{
            return fromByteArray(Array(bytes[offset..<end]), UInt64.self).bigEndian
        }else{
            return fromByteArray(Array(bytes[offset..<end]), UInt64.self)
        }
    }
    
    public func getInt8(_ offset: Int) throws -> Int8 {
        let uint: UInt8 = try getUInt8(offset)
        return Int8(bitPattern: uint)
    }
    
    public func getInt16(_ offset: Int, bigEndian: Bool? = false) throws -> Int16 {
        let uint: UInt16 = try getUInt16(offset, bigEndian: bigEndian)
        return Int16(bitPattern: uint)
    }
    
    public func getInt32(_ offset: Int, bigEndian: Bool? = false) throws -> Int32 {
        let uint: UInt32 = try getUInt32(offset, bigEndian: bigEndian)
        return Int32(bitPattern: uint)
    }
    
    public func getInt64(_ offset: Int, bigEndian: Bool? = false) throws -> Int64 {
        let uint: UInt64 = try getUInt64(offset, bigEndian: bigEndian)
        return Int64(bitPattern: uint)
    }
    
    public func getFloat32(_ offset: Int, bigEndian: Bool? = false) throws -> Float32 {
        let uint: UInt32 = try getUInt32(offset, bigEndian: bigEndian)
        return Float32(bitPattern: uint)
    }
    
    public func getFloat64(_ offset: Int, bigEndian: Bool? = false) throws -> Float64 {
        let uint: UInt64 = try getUInt64(offset, bigEndian: bigEndian)
        return Float64(bitPattern: uint)
    }
    
    public func getFloat(_ offset: Int, bigEndian: Bool? = false) throws -> Float {
        let uint: UInt32 = try getUInt32(offset, bigEndian: bigEndian)
        return Float(bitPattern: uint)
    }
    
    public func getDouble(_ offset: Int, bigEndian: Bool? = false) throws -> Double {
        let uint: UInt64 = try getUInt64(offset, bigEndian: bigEndian)
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
            throw SwiftyBytesError.IncorrectValueType
        }
    }
    
    public func getNullTerminatedString(_ offset: Int) throws -> String {
        var utf8 = UTF8()
        var string = ""
        var generator = try subData(offset, bytes.count - offset).makeIterator()

        while true {
            switch utf8.decode(&generator) {
            case .scalarValue(let unicodeScalar) where unicodeScalar.value > 0:
                string.append(String(unicodeScalar))
            case .scalarValue(_)://\0 means end of string
                return string
            case .emptyInput:
                throw SwiftyBytesError.StringConversionError
            case .error:
                throw SwiftyBytesError.StringConversionError
            }
        }
    }
    
    public func getNullTerminatedStringTrimmed(_ offset: Int) throws -> String {
        var utf8 = UTF8()
        var string = ""
        var generator = try subData(offset, bytes.count - offset).makeIterator()

        while true {
            switch utf8.decode(&generator) {
            case .scalarValue(let unicodeScalar) where unicodeScalar.value > 0:
                string.append(String(unicodeScalar))
            case .scalarValue(_)://\0 means end of string
                return string.trimmingCharacters(in: .whitespacesAndNewlines)
            case .emptyInput:
                throw SwiftyBytesError.StringConversionError
            case .error:
                throw SwiftyBytesError.StringConversionError
            }
        }
    }
    
    public func getString(_ offset: Int, length: Int) throws -> String {
      var utf8 = UTF8()
      var string = ""
      var generator = try subData(offset, length).makeIterator()
      
      while true {
        switch utf8.decode(&generator) {
        case .scalarValue(let unicodeScalar):
          string.append(String(unicodeScalar))
        case .emptyInput:
          return string
        case .error:
          throw SwiftyBytesError.StringConversionError
        }
      }
    }
    
    public func get7BitEncodedString(_ offset: Int) throws -> String {
        let stringLength = try get7BitEncodedInt(offset)
        let bytes = try subData(offset, stringLength + 1)
      
        return String(bytes: bytes, encoding: .ascii)!
    }
    private func get7BitEncodedInt(_ offset: Int) throws -> Int {
        // Read out an Int32 7 bits at a time.  The high bit
        // of the byte when on means to continue reading more bytes.
        var mutatingOffset = offset
        var count: Int = 0
        var shift: Int = 0
        var b: UInt8
        repeat {
            // Check for corruption.  Read a max of 5 bytes.
            if (shift == 5 * 7){  // 5 bytes max per Int32, shift += 7
                throw SwiftyBytesError.EndofDataError
            }

            b = try getUInt8(mutatingOffset)
            count |= Int(b & 0x7F) << shift
            shift += 7
            mutatingOffset += 1
        } while ((b & 0x80) != 0)
        return count
    }
    
    public func subData(_ offset: Int, _ length: Int) throws -> [UInt8] {
        if offset >= 0 && offset <= bytes.count && length >= 0 && (offset + length) <= bytes.count {
            return Array(bytes[offset..<(offset + length)])
        } else {
            throw SwiftyBytesError.EndofDataError
        }
    }
    
    public func getBit(_ offset: Int, _ bitIndex: Int) throws -> UInt8{
        guard offset < bytes.count else { throw SwiftyBytesError.EndofDataError }
        let byte = bytes[offset]
        
        return (byte >> bitIndex) & 1
    }
    
    private func fromByteArray<T>(_ value: [UInt8], _: T.Type) -> T {
        return value.withUnsafeBufferPointer {
            $0.baseAddress!.withMemoryRebound(to: T.self, capacity: 1) {
                $0.pointee
            }
        }
    }
}
