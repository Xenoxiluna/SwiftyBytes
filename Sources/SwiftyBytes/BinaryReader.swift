//
//  BinaryReader.swift
//  SwityBytes
//
//  Created by Quentin Berry on 2/7/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import Foundation

/// This is a class created for reading data in a linear order
public class BinaryReader {
    public private(set) var readIndex: Int
    public private(set) var bitReadIndex: Int
    public let data: BinaryData
  
    public init(_ data: BinaryData, _ readIndex: Int = 0, _ bitReadIndex: Int = 0) {
        self.data = data
        self.readIndex = readIndex
        self.bitReadIndex = bitReadIndex
    }
    
    public init(_ data: [UInt8], _ readIndex: Int = 0, _ bitReadIndex: Int = 0) {
        self.data = BinaryData(data: data)
        self.readIndex = readIndex
        self.bitReadIndex = bitReadIndex
    }
  
    /**
    Call this function for retriving a UInt8 at the current position of the array and increment.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    var reader: BinaryReader = BinaryReader(readData)
    try reader.readUInt8()
    ````
    */
    public func readUInt8() throws -> UInt8 {
        let value: UInt8 = try data.getUInt8(readIndex)
        adv(MemoryLayout<UInt8>.size)
        return value
    }
  
    /**
    Call this function for retriving an Int8 at the current position of the array and increment.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    var reader: BinaryReader = BinaryReader(readData)
    try reader.readInt8()
    ````
    */
    public func readInt8() throws -> Int8 {
        let value: Int8 = try data.getInt8(readIndex)
        adv(MemoryLayout<Int8>.size)
        return value
    }
  
    /**
    Call this function for retriving a UInt16 at the current position of the array and increment.
    - Parameters:
     - bigEndian: Boolean value to format the retrieved data as big endian or not.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    var reader: BinaryReader = BinaryReader(readData)
    try reader.readUInt16()
    ````
    */
    public func readUInt16(_ bigEndian: Bool? = false) throws -> UInt16 {
        let value: UInt16 = try data.getUInt16(readIndex, bigEndian: bigEndian)
        adv(MemoryLayout<UInt16>.size)
        return value
    }
  
    /**
    Call this function for retriving a Int16 at the current position of the array and increment.
    - Parameters:
     - bigEndian: Boolean value to format the retrieved data as big endian or not.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    var reader: BinaryReader = BinaryReader(readData)
    try reader.readInt16()
    ````
    */
    public func readInt16(_ bigEndian: Bool? = false) throws -> Int16 {
        let value: Int16 = try data.getInt16(readIndex, bigEndian: bigEndian)
        adv(MemoryLayout<Int16>.size)
        return value
    }
  
    /**
    Call this function for retriving a UInt32 at the current position of the array and increment.
    - Parameters:
     - bigEndian: Boolean value to format the retrieved data as big endian or not.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    var reader: BinaryReader = BinaryReader(readData)
    try reader.readUInt32()
    ````
    */
    public func readUInt32(_ bigEndian: Bool? = false) throws -> UInt32 {
        let value: UInt32 = try data.getUInt32(readIndex, bigEndian: bigEndian)
        adv(MemoryLayout<UInt32>.size)
        return value
    }

    /**
    Call this function for retriving a Int32 at the current position of the array and increment.
    - Parameters:
     - bigEndian: Boolean value to format the retrieved data as big endian or not.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    var reader: BinaryReader = BinaryReader(readData)
    try reader.readInt32()
    ````
    */
    public func readInt32(_ bigEndian: Bool? = false) throws -> Int32 {
        let value: Int32 = try data.getInt32(readIndex, bigEndian: bigEndian)
        adv(MemoryLayout<Int32>.size)
        return value
    }

    /**
    Call this function for retriving a UInt64 at the current position of the array and increment.
    - Parameters:
     - bigEndian: Boolean value to format the retrieved data as big endian or not.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    var reader: BinaryReader = BinaryReader(readData)
    try reader.readUInt64()
    ````
    */
    public func readUInt64(_ bigEndian: Bool? = false) throws -> UInt64 {
        let value: UInt64 = try data.getUInt64(readIndex, bigEndian: bigEndian)
        adv(MemoryLayout<UInt64>.size)
        return value
    }

    /**
    Call this function for retriving a Int64 at the current position of the array and increment.
    - Parameters:
     - bigEndian: Boolean value to format the retrieved data as big endian or not.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    var reader: BinaryReader = BinaryReader(readData)
    try reader.readInt64()
    ````
    */
    public func readInt64(_ bigEndian: Bool? = false) throws -> Int64 {
        let value: Int64 = try data.getInt64(readIndex, bigEndian: bigEndian)
        adv(MemoryLayout<Int64>.size)
        return value
    }

    /**
    Call this function for retriving a Float32 at the current position of the array and increment.
    - Parameters:
     - bigEndian: Boolean value to format the retrieved data as big endian or not.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    var reader: BinaryReader = BinaryReader(readData)
    try reader.readFloat32()
    ````
    */
    public func readFloat32(_ bigEndian: Bool? = false) throws -> Float32 {
        let value: Float32 = try data.getFloat32(readIndex, bigEndian: bigEndian)
        adv(MemoryLayout<Float32>.size)
        return value
    }

    /**
    Call this function for retriving a Float64 at the current position of the array and increment.
    - Parameters:
     - bigEndian: Boolean value to format the retrieved data as big endian or not.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    var reader: BinaryReader = BinaryReader(readData)
    try reader.readFloat64()
    ````
    */
    public func readFloat64(_ bigEndian: Bool? = false) throws -> Float64 {
        let value: Float64 = try data.getFloat64(readIndex, bigEndian: bigEndian)
        adv(MemoryLayout<Float64>.size)
        return value
    }
    
    /**
    Call this function for retriving a generic Float at the current position of the array and increment.
    - Parameters:
     - bigEndian: Boolean value to format the retrieved data as big endian or not.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    var reader: BinaryReader = BinaryReader(readData)
    try reader.readFloat()
    ````
    */
    public func readFloat(_ bigEndian: Bool? = false) throws -> Float {
        let value: Float = try data.getFloat(readIndex, bigEndian: bigEndian)
        adv(MemoryLayout<Float>.size)
        return value
    }
    
    /**
    Call this function for retriving a Double at the current position of the array and increment.
    - Parameters:
     - bigEndian: Boolean value to format the retrieved data as big endian or not.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    var reader: BinaryReader = BinaryReader(readData)
    try reader.readDouble()
    ````
    */
    public func readDouble(_ bigEndian: Bool? = false) throws -> Double {
        let value: Double = try data.getDouble(readIndex, bigEndian: bigEndian)
        adv(MemoryLayout<Double>.size)
        return value
    }
    
    /**
    Call this function for retriving a Bool at the current position of the array and increment.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    var reader: BinaryReader = BinaryReader(readData)
    try reader.readBool()
    ````
    */
    public func readBool() throws -> Bool {
        let value: Bool = try data.getBool(readIndex)
        adv(MemoryLayout<Bool>.size)
        return value
    }

    /**
    Call this function for retriving a Null Terminated UTF8 String at the current position of the array and increment.
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    var reader: BinaryReader = BinaryReader(readData)
    try reader.readNullTerminatedUTF8String()
    ````
    */
    public func readNullTerminatedUTF8String() throws -> String {
        let string = try data.getNullTerminatedUTF8String(readIndex)
        adv(string.utf8.count + 1)//Add 1 for \0
        return string
    }
    
    /**
    Call this function for retriving a 7 bit encoded string at the current position of the array and increment.
    - Parameters:
     - encoding : String.Encoding value of the string to retrieve
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    var reader: BinaryReader = BinaryReader(readData)
    try reader.readVariableLengthString(.ascii)
    ````
    */
    public func readVariableLengthString(_ encoding: String.Encoding) throws -> String {
        let string = try data.getVariableLengthString(readIndex, encoding)
        adv(string.data(using: encoding)!.count)
        return string
    }

    /**
    Call this function for retriving a Length prefixed String at the current position of the array and increment.
    - Parameters:
     - encoding : String.Encoding value of the string to retrieve
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    var reader: BinaryReader = BinaryReader(readData)
    try reader.readString(.ascii)
    ````
    */
    public func readString(_ encoding: String.Encoding) throws -> String {
        let string = try data.getString(readIndex, encoding)
        adv(MemoryLayout<Int>.size + string.data(using: encoding)!.count)
        return string
    }
    
    /**
    Call this function for retriving a Known Length UTF8 String at the current position of the array and increment.
    - Parameters:
     - length : Length of the UTF8 String
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    var reader: BinaryReader = BinaryReader(readData)
    try reader.readUTF8String(2)
    ````
    */
    public func readUTF8String(_ length: Int) throws -> String {
        let string = try data.getUTF8String(readIndex, length: length)
        adv(length)
        return string
    }
    
    /**
    Call this function for retriving a given amount of bytes at the current position of the array and increment.
    - Parameters:
     - length : Amount of bytes to read
    
    ### Usage Example: ###
    ````
    var readData: BinaryData = writeTest.data
    var reader: BinaryReader = BinaryReader(readData)
    try reader.read(10)
    ````
    */
    public func read(_ length: Int) throws -> [UInt8] {
        let subdata: [UInt8] = try data.subData(readIndex, length)
        adv(length)
        return subdata
    }
    
    // This still needs some work
    public func readBit() throws -> UInt8 {
        let value: UInt8 = try data.getBit(readIndex, bitReadIndex)
        if(bitReadIndex != 7){
            bitReadIndex = bitReadIndex + 1
        }else{
            bitReadIndex = 0
            adv(MemoryLayout<UInt8>.size)
        }
        return value
    }
    
    /**
    Call this function to move/advance the index forward by a certain amount
    - Parameters:
     - length : Length/Size to move the index
    */
    public func adv(_ length: Int){
        readIndex += length
    }
    
    /**
    Call this function to jump to a specific position/index in the data array
    - Parameters:
     - position : Position/Index to jump to
    */
    public func jmp(_ position: Int){
        readIndex = position
    }
}
