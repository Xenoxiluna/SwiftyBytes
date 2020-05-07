//
//  BinaryWritableData.swift
//  SwityBytes
//
//  Created by Quentin Berry on 2/7/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import Foundation

public class BinaryWritableData{
    public var data: Data
    
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
        return true
    }
    
    public func writeUInt16(_ uint: UInt16) throws -> Bool {
        data.append(contentsOf: uint.data)
        return true
    }
    
    public func writeUInt32(_ uint: UInt32) throws -> Bool {
        let uintBytes = uint.data
        data.append(contentsOf: uintBytes)
        return true
    }
    
    public func writeUInt64(_ uint: UInt64) throws -> Bool {
        let uintBytes = uint.data
        data.append(contentsOf: uintBytes)
        return true
    }
    
    public func writeInt8(_ int: Int8) throws -> Bool {
        let intBytes = int.data
        data.append(contentsOf: intBytes)
        return true
    }
    
    public func writeInt16(_ int: Int16) throws -> Bool {
        let intBytes = int.data
        data.append(contentsOf: intBytes)
        return true
    }
    
    public func writeInt32(_ int: Int32) throws -> Bool {
        let intBytes = int.data
        data.append(contentsOf: intBytes)
        return true
    }
    
    public func writeInt64(_ int: Int64) throws -> Bool {
        let uintBytes = int.data
        data.append(contentsOf: uintBytes)
        return true
    }
    
    public func writeFloat32(_ float32: Float32) throws -> Bool {
        let floatBytes = float32.data
        data.append(contentsOf: floatBytes)
        return true
    }
    
    public func writeFloat64(_ float64: Float64) throws -> Bool {
        let floatBytes = float64.data
        data.append(contentsOf: floatBytes)
        return true
    }
    
    public func writeString(_ string: String, encoding: String.Encoding) throws -> Bool {
        let stringBytes = string.data(using: encoding)
        if let dataBytes = stringBytes{
            data.append(contentsOf: dataBytes)
            return true
        }else{
            throw SwiftyBytesExceptions.StringConversionError
        }
    }
    
    public func write(_ bytes: [UInt8]) throws -> Bool {
      data.append(contentsOf: bytes)
      return true
    }
}
