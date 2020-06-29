//
//  DataExtensions.swift
//  SwityBytes
//
//  Created by Quentin Berry on 2/7/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import Foundation

extension Data {
    var uint8: UInt8 {
        get {
            var number: UInt8 = 0
            self.copyBytes(to:&number, count: MemoryLayout<UInt8>.size)
            return number
        }
    }

    var uint16: UInt16 {
        get {
            let uintArr = self.withUnsafeBytes { $0.load(as: UInt16.self) }
            return uintArr
        }
    }

    var uint32: UInt32 {
        get {
            let uintArr = self.withUnsafeBytes { $0.load(as: UInt32.self) }
            return uintArr
        }
    }
    
    var uint64: UInt64 {
        get {
            let uintArr = self.withUnsafeBytes { $0.load(as: UInt64.self) }
            return uintArr
        }
    }
        
    var stringASCII: String? {
        get {
            return NSString(data: self, encoding: String.Encoding.ascii.rawValue) as String?
        }
    }

    var stringUTF8: String? {
        get {
            return NSString(data: self, encoding: String.Encoding.utf8.rawValue) as String?
        }
    }
}
