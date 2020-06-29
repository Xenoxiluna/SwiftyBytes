//
//  File.swift
//  
//
//  Created by Quentin Berry on 6/28/20.
//

import Foundation

func fromByteArray<T>(_ value: [UInt8], _: T.Type) -> T {
    return value.withUnsafeBufferPointer {
        $0.baseAddress!.withMemoryRebound(to: T.self, capacity: 1) {
            $0.pointee
        }
    }
}
