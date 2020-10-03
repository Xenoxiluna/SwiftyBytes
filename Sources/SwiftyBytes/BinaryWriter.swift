//
//  BinaryWriter.swift
//  SwityBytes
//
//  Created by Quentin Berry on 2/7/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import Foundation

/// This is a class created for writing data in a linear order
public class BinaryWriter{
    public var data: BinaryData
    public private(set) var writeIndex: Int = 0
    public private(set) var writeBitIndex: Int = 0
    
    public init(data: [UInt8]) {
        self.data = BinaryData(data: data)
    }
    
    public init(data: Data) {
        self.data = BinaryData(data: data)
    }
    
    public init() {
        self.data = BinaryData()
    }
    
    /**
    Call this function to add the given UInt8 to the data array
    - Parameters:
     - uint : Number to write into the byte stream
    
    ### Usage Example: ###
    ````
    var writeTest: BinaryWriter = BinaryWriter()
    try writeTest.writeUInt8(65)
    ````
    */
    public func writeUInt8(_ uint: UInt8) throws -> Bool {
        data.bytes.append(contentsOf: [uint])
        writeIndex += MemoryLayout<UInt8>.size
        return true
    }
    
    /**
    Call this function to add the given UInt16 to the data array
    - Parameters:
     - uint : Number to write into the byte stream
     - bigEndian: Boolean flag to format the inserted data as big endian or not.
    
    ### Usage Example: ###
    ````
    var writeTest: BinaryWriter = BinaryWriter()
    try writeTest.writeUInt8(65)
    ````
    */
    public func writeUInt16(_ uint: UInt16, bigEndian: Bool? = false) throws -> Bool {
        let uintBytes = bigEndian ?? false ? uint.bigEndian.data : uint.data
        data.bytes.append(contentsOf: uintBytes)
        writeIndex += MemoryLayout<UInt16>.size
        return true
    }
    
    /**
    Call this function to add the given UInt32 to the data array
    - Parameters:
     - uint : Number to write into the byte stream
     - bigEndian: Boolean flag to format the inserted data as big endian or not.
    
    ### Usage Example: ###
    ````
    var writeTest: BinaryWriter = BinaryWriter()
    try writeTest.writeUInt32(65)
    ````
    */
    public func writeUInt32(_ uint: UInt32, bigEndian: Bool? = false) throws -> Bool {
        let uintBytes = bigEndian ?? false ? uint.bigEndian.data : uint.data
        data.bytes.append(contentsOf: uintBytes)
        writeIndex += MemoryLayout<UInt32>.size
        return true
    }
    
    /**
    Call this function to add the given UInt64 to the data array
    - Parameters:
     - uint : Number to write into the byte stream
     - bigEndian: Boolean flag to format the inserted data as big endian or not.
    
    ### Usage Example: ###
    ````
    var writeTest: BinaryWriter = BinaryWriter()
    try writeTest.writeUInt64(65)
    ````
    */
    public func writeUInt64(_ uint: UInt64, bigEndian: Bool? = false) throws -> Bool {
        let uintBytes = bigEndian ?? false ? uint.bigEndian.data : uint.data
        data.bytes.append(contentsOf: uintBytes)
        writeIndex += MemoryLayout<UInt64>.size
        return true
    }
    
    /**
    Call this function to add the given Int8 to the data array
    - Parameters:
     - int : Number to write into the byte stream
     - bigEndian: Boolean flag to format the inserted data as big endian or not.
    
    ### Usage Example: ###
    ````
    var writeTest: BinaryWriter = BinaryWriter()
    try writeTest.writeInt8(65)
    ````
    */
    public func writeInt8(_ int: Int8) throws -> Bool {
        let intBytes = int.data
        data.bytes.append(contentsOf: intBytes)
        writeIndex += MemoryLayout<Int8>.size
        return true
    }
    
    /**
    Call this function to add the given Int16 to the data array
    - Parameters:
     - int : Number to write into the byte stream
     - bigEndian: Boolean flag to format the inserted data as big endian or not.
    
    ### Usage Example: ###
    ````
    var writeTest: BinaryWriter = BinaryWriter()
    try writeTest.writeInt16(65)
    ````
    */
    public func writeInt16(_ int: Int16, bigEndian: Bool? = false) throws -> Bool {
        let intBytes = bigEndian ?? false ? int.bigEndian.data : int.data
        data.bytes.append(contentsOf: intBytes)
        writeIndex += MemoryLayout<Int16>.size
        return true
    }
    
    /**
    Call this function to add the given Int32 to the data array
    - Parameters:
     - int : Number to write into the byte stream
     - bigEndian: Boolean flag to format the inserted data as big endian or not.
    
    ### Usage Example: ###
    ````
    var writeTest: BinaryWriter = BinaryWriter()
    try writeTest.writeInt32(65)
    ````
    */
    public func writeInt32(_ int: Int32, bigEndian: Bool? = false) throws -> Bool {
        let intBytes = bigEndian ?? false ? int.bigEndian.data : int.data
        data.bytes.append(contentsOf: intBytes)
        writeIndex += MemoryLayout<Int32>.size
        return true
    }
    
    /**
    Call this function to add the given Int64 to the data array
    - Parameters:
     - int : Number to write into the byte stream
     - bigEndian: Boolean flag to format the inserted data as big endian or not.
    
    ### Usage Example: ###
    ````
    var writeTest: BinaryWriter = BinaryWriter()
    try writeTest.writeInt64(65)
    ````
    */
    public func writeInt64(_ int: Int64, bigEndian: Bool? = false) throws -> Bool {
        let intBytes = bigEndian ?? false ? int.bigEndian.data : int.data
        data.bytes.append(contentsOf: intBytes)
        writeIndex += MemoryLayout<Int64>.size
        return true
    }
    
    /**
    Call this function to add the given Float32 to the data array
    - Parameters:
     - float32 : Number to write into the byte stream
     - bigEndian: Boolean flag to format the inserted data as big endian or not.
    
    ### Usage Example: ###
    ````
    var writeTest: BinaryWriter = BinaryWriter()
    try writeTest.writeFloat32(65)
    ````
    */
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
    
    /**
    Call this function to add the given Float64 to the data array
    - Parameters:
     - float64 : Number to write into the byte stream
     - bigEndian: Boolean flag to format the inserted data as big endian or not.
    
    ### Usage Example: ###
    ````
    var writeTest: BinaryWriter = BinaryWriter()
    try writeTest.writeFloat64(65)
    ````
    */
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
    
    /**
    Call this function to add the given Double to the data array
    - Parameters:
     - double : Number to write into the byte stream
     - bigEndian: Boolean flag to format the inserted data as big endian or not.
    
    ### Usage Example: ###
    ````
    var writeTest: BinaryWriter = BinaryWriter()
    try writeTest.writeDouble(65)
    ````
    */
    public func writeDouble(_ double: Double, bigEndian: Bool? = false) throws -> Bool {
        let _ = try writeFloat64(double, bigEndian: bigEndian)
        return true
    }
    
    /**
    Call this function to add the given Bool to the data array
    - Parameters:
     - bool : Boolean value to write into the byte stream
    
    ### Usage Example: ###
    ````
    var writeTest: BinaryWriter = BinaryWriter()
    try writeTest.writeBool(true)
    ````
    */
    public func writeBool(_ bool: Bool) throws -> Bool {
        if bool{
            let _ = try self.writeUInt8(1)
        }else{
            let _ = try self.writeUInt8(0)
        }
        writeIndex += MemoryLayout<Bool>.size
        return true
    }
    
    /**
    Call this function for storing a Length prefixed String into the data array
    - Parameters:
     - string : String to write into the byte stream
     - encoding : String.Encoding value of the string
    
    ### Usage Example: ###
    ````
    var writeTest: BinaryWriter = BinaryWriter()
    try writeTest.writeString("This is a test!", .ascii)
    ````
    */
    public func writeString(_ string: String, _ encoding: String.Encoding) throws -> Bool {
        let stringBytes = string.data(using: encoding)
        if let dataBytes = stringBytes{
            let strByteCount = dataBytes.count.data
            data.bytes.append(contentsOf: strByteCount)
            data.bytes.append(contentsOf: dataBytes)
            writeIndex += dataBytes.count
            return true
        }else{
            throw SwiftyBytesError.StringConversionError
        }
    }
    
     /**
       Call this function for storing a string as Null Terminated UTF8 into the data array
       - Parameters:
        - string : String to write into the byte stream
       
       ### Usage Example: ###
       ````
       var writeTest: BinaryWriter = BinaryWriter()
       try writeTest.writeNullTerminatedUTF8String("This is a test!")
       ````
    */
    public func writeNullTerminatedUTF8String(_ string: String) throws -> Bool {
        let stringBytes = string.nullTerminated(using: .utf8)
        if let dataBytes = stringBytes{
            data.bytes.append(contentsOf: dataBytes)
            writeIndex += dataBytes.count + 1
            return true
        }else{
            throw SwiftyBytesError.StringConversionError
        }
    }
    
    /**
    Call this function for storing a 7 bit encoded String into the data array
    - Parameters:
     - string : String to write into the byte stream
     - encoding : String.Encoding value of the string
    
    ### Usage Example: ###
    ````
    var writeTest: BinaryWriter = BinaryWriter()
    try writeTest.writeVariableLengthString("This is a test!", .ascii)
    ````
    */
    public func writeVariableLengthString(_ string: String, _ encoding: String.Encoding) throws -> Bool {
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
    
    /**
    Call this function for storing a 7 bit encoded String into the data array
    - Parameters:
     - bytes : Bytes to write into the byte stream
    
    ### Usage Example: ###
    ````
    var writeTest: BinaryWriter = BinaryWriter()
    try writeTest.write([0, 1, 3, 4])
    ````
    */
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
