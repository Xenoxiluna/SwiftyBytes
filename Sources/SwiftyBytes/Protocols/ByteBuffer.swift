//
//  ByteBuffer.swift
//  SwiftyBytes
//
//  Created by Quentin Berry on 6/28/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import Foundation

/// This is a protocal created for handling the retrieval of various numbers and strings
public protocol ByteBuffer {
    var bytes: [UInt8] { get set }
    var count: Int { get }
}

extension ByteBuffer{
    
    /**
    Call this function for retriving a UInt8 at a specific offset in the array
    - Parameters:
     - offset : The Index of the array to retreive data from.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    let num = readData.getUInt8(1)
    ````
    */
    public func getUInt8(_ offset: Int) throws -> UInt8 {
        guard offset < bytes.count else { throw SwiftyBytesError.EndofDataError }
        return bytes[offset]
    }
    
    /**
    Call this function for retriving a UInt16 at a specific offset in the array
    - Parameters:
     - offset : The Index of the array to retreive data from.
     - bigEndian: Boolean value to format the retrieved data as big endian or not.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    let num = readData.getUInt16(1)
    ````
    */
    public func getUInt16(_ offset: Int, bigEndian: Bool? = false) throws -> UInt16 {
        guard offset + 1 < bytes.count else { throw SwiftyBytesError.EndofDataError }
        let end = offset + MemoryLayout<UInt16>.size
        if bigEndian ?? false{
            return fromByteArray(Array(bytes[offset..<end]), UInt16.self).bigEndian
        }else{
            return fromByteArray(Array(bytes[offset..<end]), UInt16.self)
        }
    }
    
    /**
    Call this function for retriving a UInt32 at a specific offset in the array
    - Parameters:
     - offset : The Index of the array to retreive data from.
     - bigEndian: Boolean value to format the retrieved data as big endian or not.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    let num = readData.getUInt32(1)
    ````
    */
    public func getUInt32(_ offset: Int, bigEndian: Bool? = false) throws -> UInt32 {
        guard offset + 3 < bytes.count else { throw SwiftyBytesError.EndofDataError }
        let end = offset + MemoryLayout<UInt32>.size
        if bigEndian ?? false{
            return fromByteArray(Array(bytes[offset..<end]), UInt32.self).bigEndian
        }else{
            return fromByteArray(Array(bytes[offset..<end]), UInt32.self)
        }
    }
    
    /**
    Call this function for retriving a UInt64 at a specific offset in the array
    - Parameters:
     - offset : The Index of the array to retreive data from.
     - bigEndian: Boolean value to format the retrieved data as big endian or not.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    let num = readData.getUInt64(1)
    ````
    */
    public func getUInt64(_ offset: Int, bigEndian: Bool? = false) throws -> UInt64 {
        guard offset + 7 < bytes.count else { throw SwiftyBytesError.EndofDataError }
        let end = offset + MemoryLayout<UInt64>.size
        if bigEndian ?? false{
            return fromByteArray(Array(bytes[offset..<end]), UInt64.self).bigEndian
        }else{
            return fromByteArray(Array(bytes[offset..<end]), UInt64.self)
        }
    }
    
    /**
    Call this function for retriving a Int8 at a specific offset in the array
    - Parameters:
     - offset : The Index of the array to retreive data from.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    let num = readData.getInt8(1)
    ````
    */
    public func getInt8(_ offset: Int) throws -> Int8 {
        let uint: UInt8 = try getUInt8(offset)
        return Int8(bitPattern: uint)
    }
    
    /**
    Call this function for retriving a Int16 at a specific offset in the array
    - Parameters:
     - offset : The Index of the array to retreive data from.
     - bigEndian: Boolean value to format the retrieved data as big endian or not.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    let num = readData.getInt16(1)
    ````
    */
    public func getInt16(_ offset: Int, bigEndian: Bool? = false) throws -> Int16 {
        let uint: UInt16 = try getUInt16(offset, bigEndian: bigEndian)
        return Int16(bitPattern: uint)
    }
    
    
    /**
    Call this function for retriving a Int32 at a specific offset in the array
    - Parameters:
     - offset : The Index of the array to retreive data from.
     - bigEndian: Boolean value to format the retrieved data as big endian or not.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    let num = readData.getInt32(1)
    ````
    */
    public func getInt32(_ offset: Int, bigEndian: Bool? = false) throws -> Int32 {
        let uint: UInt32 = try getUInt32(offset, bigEndian: bigEndian)
        return Int32(bitPattern: uint)
    }
    
    /**
    Call this function for retriving a Int64 at a specific offset in the array
    - Parameters:
     - offset : The Index of the array to retreive data from.
     - bigEndian: Boolean value to format the retrieved data as big endian or not.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    let num = readData.getInt64(1)
    ````
    */
    public func getInt64(_ offset: Int, bigEndian: Bool? = false) throws -> Int64 {
        let uint: UInt64 = try getUInt64(offset, bigEndian: bigEndian)
        return Int64(bitPattern: uint)
    }
    
    /**
    Call this function for retriving a generic Int at a specific offset in the array
    - Parameters:
     - offset : The Index of the array to retreive data from.
     - bigEndian: Boolean value to format the retrieved data as big endian or not.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    let num = readData.getInt(1)
    ````
    */
    public func getInt(_ offset: Int, bigEndian: Bool? = false) throws -> Int {
        guard offset + (MemoryLayout<Int>.size - 1) < bytes.count else { throw SwiftyBytesError.EndofDataError }
        let end = offset + MemoryLayout<Int>.size
        if bigEndian ?? false{
            return fromByteArray(Array(bytes[offset..<end]), Int.self).bigEndian
        }else{
            return fromByteArray(Array(bytes[offset..<end]), Int.self)
        }
    }
    
    /**
    Call this function for retriving a Float32 at a specific offset in the array
    - Parameters:
     - offset : The Index of the array to retreive data from.
     - bigEndian: Boolean value to format the retrieved data as big endian or not.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    let num = readData.getFloat32(1)
    ````
    */
    public func getFloat32(_ offset: Int, bigEndian: Bool? = false) throws -> Float32 {
        let uint: UInt32 = try getUInt32(offset, bigEndian: bigEndian)
        return Float32(bitPattern: uint)
    }
    
    /**
    Call this function for retriving a Float64 at a specific offset in the array
    - Parameters:
     - offset : The Index of the array to retreive data from.
     - bigEndian: Boolean value to format the retrieved data as big endian or not.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    let num = readData.getFloat64(1)
    ````
    */
    public func getFloat64(_ offset: Int, bigEndian: Bool? = false) throws -> Float64 {
        let uint: UInt64 = try getUInt64(offset, bigEndian: bigEndian)
        return Float64(bitPattern: uint)
    }
    
    /**
    Call this function for retriving a generic Float at a specific offset in the array
    - Parameters:
     - offset : The Index of the array to retreive data from.
     - bigEndian: Boolean value to format the retrieved data as big endian or not.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    let num = readData.getFloat(1)
    ````
    */
    public func getFloat(_ offset: Int, bigEndian: Bool? = false) throws -> Float {
        let uint: UInt32 = try getUInt32(offset, bigEndian: bigEndian)
        return Float(bitPattern: uint)
    }
    
    /**
    Call this function for retriving a Double at a specific offset in the array
    - Parameters:
     - offset : The Index of the array to retreive data from.
     - bigEndian: Boolean value to format the retrieved data as big endian or not.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    let num = readData.getDouble(1)
    ````
    */
    public func getDouble(_ offset: Int, bigEndian: Bool? = false) throws -> Double {
        let uint: UInt64 = try getUInt64(offset, bigEndian: bigEndian)
        return Double(bitPattern: uint)
    }
    
    /**
    Call this function for retriving a Bool at a specific offset in the array
    - Parameters:
     - offset : The Index of the array to retreive data from.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    let num = readData.getBool(1)
    ````
    */
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
    
    /**
    Call this function for retriving a Null Terminated UTF8 String at a specific offset in the array
    - Parameters:
     - offset : The Index of the array to retreive data from.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    let num = readData.getNullTerminatedUTF8String(28)
    ````
    */
    public func getNullTerminatedUTF8String(_ offset: Int) throws -> String {
        var utf8 = UTF8()
        var string = ""
        var generator = try subData(offset, bytes.count - offset).makeIterator()

        while true {
            switch utf8.decode(&generator) {
            case .scalarValue(let unicodeScalar) where unicodeScalar.value > 0:
                string.append(String(unicodeScalar))
            case .scalarValue(_)://\0 for end of string
                return string
            case .emptyInput:
                throw SwiftyBytesError.StringConversionError
            case .error:
                throw SwiftyBytesError.StringConversionError
            }
        }
    }
    
    /**
    Call this function for retriving a UTF8 String at a specific offset in the array
    - Parameters:
     - offset : The Index of the array to retreive data from.
     - length : Length of the string
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    let num = readData.getUTF8String(1, length: 6)
    ````
    */
    public func getUTF8String(_ offset: Int, length: Int) throws -> String {
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
    
    /**
    Call this function for retriving a String at a specific offset in the array
    - Parameters:
     - offset : The Index of the array to retreive data from.
     - encoding : String.Encoding value of the string to retrieve
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    let num = readData.getString(1, .ascii)
    ````
    */
    public func getString(_ offset: Int, _ encoding: String.Encoding) throws -> String {
        let stringLength = try getInt(offset)
        let bytes = try subData(offset + MemoryLayout<Int>.size, stringLength)
      
        guard let str = String(bytes: bytes, encoding: encoding) else {
            throw SwiftyBytesError.StringConversionError
        }
        return str
    }
    
    /**
    Call this function for retriving a 7 Bit Encoded Variable Length String at a specific offset in the array.
    - Parameters:
     - offset : The Index of the array to retreive data from.
     - encoding : String.Encoding value of the string to retrieve
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    let num = readData.getVariableLengthString(1, .ascii)
    ````
    */
    public func getVariableLengthString(_ offset: Int, _ encoding: String.Encoding) throws -> String {
        let stringLength = try get7BitEncodedInt(offset)
        let bytes = try subData(offset, stringLength + 1)
      
        guard let str = String(bytes: bytes, encoding: encoding) else {
            throw SwiftyBytesError.StringConversionError
        }
        return str
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
    
    /**
    Call this function for retriving a  Array of UInt8(Bytes) at a specific offset in the array.
    - Parameters:
     - offset : The Index of the array to retreive data from.
     - length : Amount of bytes to retrieve
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    let num = readData.subData(1, 10)
    ````
    */
    public func subData(_ offset: Int, _ length: Int) throws -> [UInt8] {
        guard offset >= 0 && offset <= bytes.count && length >= 0 && (offset + length) <= bytes.count else {
            throw SwiftyBytesError.EndofDataError
        }
        return Array(bytes[offset..<(offset + length)])
    }
    
    /**
    Call this function for retriving a bit value at a specific offset in the array.
    - Parameters:
     - offset : The Index of the array to retreive data from.
     - bitIndex : The index of the bit you would like to retrieve
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    let num = readData.getBit(1, 4)
    ````
    */
    public func getBit(_ offset: Int, _ bitIndex: Int) throws -> UInt8{
        guard offset < bytes.count else { throw SwiftyBytesError.EndofDataError }
        let byte = bytes[offset]
        
        return (byte >> bitIndex) & 1
    }
}
