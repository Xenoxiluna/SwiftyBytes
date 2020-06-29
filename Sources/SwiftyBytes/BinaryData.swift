//
//  BinaryReadableData.swift
//  SwityBytes
//
//  Created by Quentin Berry on 2/7/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import Foundation

public struct BinaryData: ByteBuffer{
    public var bytes: [UInt8] = []
    public var count: Int { get { return self.bytes.count }}
    
    public init(data: [UInt8]) {
        self.bytes = data
    }
    
    public init(data: Data) {
        self.bytes = [UInt8](data)
    }
    
    public init(){}
}
