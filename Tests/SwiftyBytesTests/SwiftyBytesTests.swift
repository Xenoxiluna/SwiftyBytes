//
//  SwiftyBytesTests.swift
//  SwityBytes
//
//  Created by Quentin Berry on 5/6/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import XCTest
@testable import SwiftyBytes

final class SwiftyBytesTests: XCTestCase {
    func testReadWriteNullTerminated() throws{
        var writeTest: BinaryWriter = BinaryWriter()
        try writeTest.writeNullTerminatedString("""
        This is a test!
        This is a test!
        """, encoding: .utf8)
        try writeTest.writeUInt16(1)

        var readData: BinaryReadableData = BinaryReadableData(data: writeTest.data)
        var reader: BinaryReader = BinaryReader(readData)
        XCTAssertEqual(try reader.readNullTerminatedString(), """
        This is a test!
        This is a test!
        """)
        XCTAssertEqual(try reader.readUInt16(), 1)
    }
    
    func testReadWrite7bitEncodedString() throws{
        var writeTest: BinaryWriter = BinaryWriter()
        try writeTest.write7BitEncodedString("This is a test!", encoding: .utf8)

        var readData: BinaryReadableData = BinaryReadableData(data: writeTest.data)
        var reader: BinaryReader = BinaryReader(readData)
        XCTAssertEqual(try reader.read7BitEncodedString(), "\u{f}This is a test!")
    }
    
    func testReadWrite7bitEncodedStringMulti() throws{
        var writeTest: BinaryWriter = BinaryWriter()
        try writeTest.write7BitEncodedString("This is a test!", encoding: .utf8)
        try writeTest.write7BitEncodedString("", encoding: .utf8)
        try writeTest.writeUInt64(866464616516564)

        var readData: BinaryReadableData = BinaryReadableData(data: writeTest.data)
        var reader: BinaryReader = BinaryReader(readData)
        XCTAssertEqual(try reader.read7BitEncodedString(), "\u{f}This is a test!")
        XCTAssertEqual(try reader.read7BitEncodedString(), "\u{0}")
        XCTAssertEqual(try reader.readUInt64(), 866464616516564)
    }
    
    func testReadWriteMixedString() throws{
        var writeTest: BinaryWriter = BinaryWriter()
        try writeTest.write7BitEncodedString("This is a test!", encoding: .utf8)
        try writeTest.writeNullTerminatedString("This is my second test!", encoding: .utf8)
        try writeTest.writeUInt64(866464616516564)

        var readData: BinaryReadableData = BinaryReadableData(data: writeTest.data)
        var reader: BinaryReader = BinaryReader(readData)
        XCTAssertEqual(try reader.read7BitEncodedString(), "\u{f}This is a test!")
        XCTAssertEqual(try reader.readNullTerminatedString(), "This is my second test!")
        XCTAssertEqual(try reader.readUInt64(), 866464616516564)
    }
    
    func testReadWriteGeneric() throws{
        //XCTAssertEqual(SwiftyBytes().text, "Hello, World!")
        var writeTest: BinaryWriter = BinaryWriter()
        try writeTest.writeUInt32(1337)
        try writeTest.writeString("""
        This is a test!
        This is a test!
        This is a test!
        This is a test!
        This is a test!
        """, encoding: .utf8)
        try writeTest.writeUInt16(12)
        try writeTest.writeUInt32(1337)
        try writeTest.writeUInt8(255)

        var readData: BinaryReadableData = BinaryReadableData(data: writeTest.data)
        var reader: BinaryReader = BinaryReader(readData)
        XCTAssertEqual(try reader.readUInt32(), 1337)
        XCTAssertEqual(try reader.readNullTerminatedStringTrimmed(), """
        This is a test!
        This is a test!
        This is a test!
        This is a test!
        This is a test!
        """)
        XCTAssertEqual(try reader.readUInt16(), 12)
        XCTAssertEqual(try reader.readUInt32(), 1337)
        XCTAssertEqual(try reader.readUInt8(), 255)
    }
    
    func testReadWriteBit() throws{
        var writeTest: BinaryWriter = BinaryWriter()
        try writeTest.writeUInt8(14)
        try writeTest.writeBit(true, 0)
        try writeTest.writeBit(true, 7)
        XCTAssertThrowsError(try writeTest.writeBit(false, 12))
        try writeTest.writeUInt8(15)

        var readData: BinaryReadableData = BinaryReadableData(data: writeTest.data)
        var reader: BinaryReader = BinaryReader(readData)
        XCTAssertEqual(try reader.readBit(), 1)
        XCTAssertEqual(try reader.readBit(), 1)
        XCTAssertEqual(try reader.readBit(), 1)
        XCTAssertEqual(try reader.readBit(), 1)
        XCTAssertEqual(try reader.readBit(), 0)
        XCTAssertEqual(try reader.readBit(), 0)
        XCTAssertEqual(try reader.readBit(), 0)
        XCTAssertEqual(try reader.readBit(), 1)
        XCTAssertEqual(try reader.readUInt8(), 15)
    }
    
    func testUInt8BitExtension() throws{
        let testNum: UInt8 = 14
        XCTAssertEqual(testNum.bits, [0,1,1,1,0,0,0,0])
    }

    static var allTests = [
        ("testReadWrite7bitEncodedString", testReadWrite7bitEncodedString),
        ("testReadWrite7bitEncodedStringMulti", testReadWrite7bitEncodedStringMulti),
        ("testReadWriteMixedString", testReadWriteMixedString),
        ("testReadWriteGeneric", testReadWriteGeneric),
        ("testReadWriteNullTerminated", testReadWriteNullTerminated),
        ("testReadWriteBit", testReadWriteBit),
        ("testUInt8BitExtension", testUInt8BitExtension),
    ]
}
