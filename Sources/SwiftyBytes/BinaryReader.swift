//
//  BinaryReader.swift
//  SwityBytes
//
//  Created by Quentin Berry on 2/7/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import Foundation

public class BinaryReader {
    public private(set) var readIndex: Int
    public private(set) var bitReadIndex: Int
    public let data: BinaryReadableData
  
    public init(_ data: BinaryReadableData, readIndex: Int = 0, bitReadIndex: Int = 0) {
        self.data = data
        self.readIndex = readIndex
        self.bitReadIndex = bitReadIndex
    }
  
    public func readUInt8() throws -> UInt8 {
        let value: UInt8 = try data.getUInt8(readIndex)
        readIndex = readIndex + MemoryLayout<UInt8>.size
        return value
    }
  
    public func readInt8() throws -> Int8 {
        let value: Int8 = try data.getInt8(readIndex)
        readIndex = readIndex + MemoryLayout<Int8>.size
        return value
    }
  
    public func readUInt16() throws -> UInt16 {
        let value: UInt16 = try data.getUInt16(readIndex)
        readIndex = readIndex + MemoryLayout<UInt16>.size
        return value
    }
  
    public func readInt16() throws -> Int16 {
        let value: Int16 = try data.getInt16(readIndex)
        readIndex = readIndex + MemoryLayout<Int16>.size
        return value
    }
  
    public func readUInt32() throws -> UInt32 {
        let value: UInt32 = try data.getUInt32(readIndex)
        readIndex = readIndex + MemoryLayout<UInt32>.size
        return value
    }

    public func readInt32() throws -> Int32 {
        let value: Int32 = try data.getInt32(readIndex)
        readIndex = readIndex + MemoryLayout<Int32>.size
        return value
    }

    public func readUInt64() throws -> UInt64 {
        let value: UInt64 = try data.getUInt64(readIndex)
        readIndex = readIndex + MemoryLayout<UInt64>.size
        return value
    }

    public func readInt64() throws -> Int64 {
        let value: Int64 = try data.getInt64(readIndex)
        readIndex = readIndex + MemoryLayout<Int64>.size
        return value
    }

    public func readFloat32() throws -> Float32 {
        let value: Float32 = try data.getFloat32(readIndex)
        readIndex = readIndex + MemoryLayout<Float32>.size
        return value
    }

    public func readFloat64() throws -> Float64 {
        let value: Float64 = try data.getFloat64(readIndex)
        readIndex = readIndex + MemoryLayout<Float64>.size
        return value
    }
    
    public func readFloat() throws -> Float {
        let value: Float = try data.getFloat(readIndex)
        readIndex = readIndex + MemoryLayout<Float>.size
        return value
    }
    
    public func readDouble() throws -> Double {
        let value: Double = try data.getDouble(readIndex)
        readIndex = readIndex + MemoryLayout<Double>.size
        return value
    }
    
    public func readBool() throws -> Bool {
        let value: Bool = try data.getBool(readIndex)
        readIndex = readIndex + MemoryLayout<Bool>.size
        return value
    }

    public func readNullTerminatedString() throws -> String {
        let string = try data.getNullTerminatedString(readIndex)
        readIndex = readIndex + string.utf8.count + 1//Add 1 for \0
        return string
    }
    
    public func readNullTerminatedStringNoTrail() throws -> String {
      let string = try data.getNullTerminatedString(readIndex)
      readIndex = readIndex + string.utf8.count
      return string
    }
    
    public func readNullTerminatedStringTrimmed() throws -> String {
      let string = try data.getNullTerminatedStringTrimmed(readIndex)
      readIndex = readIndex + string.utf8.count
      return string
    }
    
    public func read7BitEncodedString() throws -> String {
      let string = try data.get7BitEncodedString(readIndex)
      readIndex = readIndex + string.utf8.count
      return string
    }

    public func readString(_ length: Int) throws -> String {
        let string = try data.getString(readIndex, length: length)
        readIndex = readIndex + length
        return string
    }
    
    public func read(_ length: Int) throws -> BinaryReadableData {
        let subdata: BinaryReadableData = try data.subData(readIndex, length)
        readIndex = readIndex + length
        return subdata
    }
    
    public func read(_ length: Int) throws -> [UInt8] {
        let subdata: [UInt8] = try data.subData(readIndex, length)
        readIndex = readIndex + length
        return subdata
    }
    
    // This still needs some work
    public func readBit() throws -> UInt8 {
        let value: UInt8 = try data.getBit(readIndex, bitReadIndex)
        if(bitReadIndex != 7){
            bitReadIndex = bitReadIndex + 1
        }else{
            bitReadIndex = 0
            readIndex = readIndex + MemoryLayout<UInt8>.size
        }
        return value
    }
}
