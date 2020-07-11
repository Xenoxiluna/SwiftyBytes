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
        let writeTest: BinaryWriter = BinaryWriter()
        let _ = try writeTest.writeNullTerminatedUTF8String("""
        This is a test!
        This is a test!
        """)
        let _ = try writeTest.writeUInt16(1)

        let readData: BinaryData = writeTest.data
        let reader: BinaryReader = BinaryReader(readData)
        XCTAssertEqual(try reader.readNullTerminatedUTF8String(), """
        This is a test!
        This is a test!
        """)
        XCTAssertEqual(try reader.readUInt16(), 1)
    }
    
    func testReadWrite7bitEncodedString() throws{
        let writeTest: BinaryWriter = BinaryWriter()
        let _ = try writeTest.writeVariableLengthString("This is a test!", .utf8)

        let readData: BinaryData = writeTest.data
        let reader: BinaryReader = BinaryReader(readData)
        XCTAssertEqual(try reader.readVariableLengthString(.utf8), "\u{f}This is a test!")
    }
    
    func testReadWrite7bitEncodedStringMulti() throws{
        let writeTest: BinaryWriter = BinaryWriter()
        let _ = try writeTest.writeVariableLengthString("This is a test!", .utf8)
        let _ = try writeTest.writeVariableLengthString("", .utf8)
        let _ = try writeTest.writeUInt64(866464616516564)

        let readData: BinaryData = writeTest.data
        let reader: BinaryReader = BinaryReader(readData)
        XCTAssertEqual(try reader.readVariableLengthString(.utf8), "\u{f}This is a test!")
        XCTAssertEqual(try reader.readVariableLengthString(.utf8), "\u{0}")
        XCTAssertEqual(try reader.readUInt64(), 866464616516564)
    }
    
    func testReadWriteStringEncoding() throws{
        let writeTest: BinaryWriter = BinaryWriter()
        let _ = try writeTest.writeUInt32(1337)
        let _ = try writeTest.writeString("This is a test!", .utf8)
        let _ = try writeTest.writeUInt16(12)
        let _ = try writeTest.writeUInt8(255)
        let _ = try writeTest.writeString("This is a utf16 test!", .utf16)
        let _ = try writeTest.writeString("This is a unicode test!", .unicode)
        let _ = try writeTest.writeUInt16(255)
        let _ = try writeTest.writeString("This is an ascii test!", .ascii)

        let readData: BinaryData = writeTest.data
        let reader: BinaryReader = BinaryReader(readData)
        print(readData.bytes)
        XCTAssertEqual(try reader.readUInt32(), 1337)
        XCTAssertEqual(try reader.readString(.utf8), "This is a test!")
        XCTAssertEqual(try reader.readUInt16(), 12)
        XCTAssertEqual(try reader.readUInt8(), 255)
        XCTAssertEqual(try reader.readString(.utf16), "This is a utf16 test!")
        XCTAssertEqual(try reader.readString(.unicode), "This is a unicode test!")
        XCTAssertEqual(try reader.readUInt16(), 255)
        XCTAssertEqual(try reader.readString(.ascii), "This is an ascii test!")
    }
    
    func testReadWriteMixedString() throws{
        let writeTest: BinaryWriter = BinaryWriter()
        let _ = try writeTest.writeVariableLengthString("This is a test!", .utf8)
        let _ = try writeTest.writeNullTerminatedUTF8String("This is my second test!")
        let _ = try writeTest.writeUInt64(866464616516564)

        let readData: BinaryData = writeTest.data
        let reader: BinaryReader = BinaryReader(readData)
        XCTAssertEqual(try reader.readVariableLengthString(.utf8), "\u{f}This is a test!")
        XCTAssertEqual(try reader.readNullTerminatedUTF8String(), "This is my second test!")
        XCTAssertEqual(try reader.readUInt64(), 866464616516564)
    }
    
    func testReadWriteGeneric() throws{
        //XCTAssertEqual(SwiftyBytes().text, "Hello, World!")
        let writeTest: BinaryWriter = BinaryWriter()
        let _ = try writeTest.writeUInt32(1337)
        let _ = try writeTest.writeString("""
        This is a test!
        This is a test!
        This is a test!
        This is a test!
        This is a test!
        """, .utf8)
        let _ = try writeTest.writeUInt16(12)
        let _ = try writeTest.writeUInt32(1337)
        let _ = try writeTest.writeUInt8(255)

        let readData: BinaryData = writeTest.data
        let reader: BinaryReader = BinaryReader(readData)
        XCTAssertEqual(try reader.readUInt32(), 1337)
        XCTAssertEqual(try reader.readString(.utf8), """
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
        let writeTest: BinaryWriter = BinaryWriter()
        let _ = try writeTest.writeUInt8(14)
        let _ = try writeTest.writeBit(true, 0)
        let _ = try writeTest.writeBit(true, 7)
        XCTAssertThrowsError(try writeTest.writeBit(false, 12))
        let _ = try writeTest.writeUInt8(15)

        let readData: BinaryData = writeTest.data
        let reader: BinaryReader = BinaryReader(readData)
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
    
    func testBigEndian() throws{
        let writeTest: BinaryWriter = BinaryWriter()
        let _ = try writeTest.writeVariableLengthString("This is a test!", .utf8)
        let _ = try writeTest.writeUInt64(866464616516564, bigEndian: true)
        let _ = try writeTest.writeUInt32(866464616, bigEndian: true)
        let _ = try writeTest.writeUInt16(8664, bigEndian: true)
        let _ = try writeTest.writeInt16(8664, bigEndian: true)
        let _ = try writeTest.writeFloat64(8664.20, bigEndian: true)
        let _ = try writeTest.writeFloat32(866.20, bigEndian: true)

        let readData: BinaryData = writeTest.data
        let reader: BinaryReader = BinaryReader(readData)
        XCTAssertEqual(try reader.readVariableLengthString(.utf8), "\u{f}This is a test!")
        XCTAssertEqual(try reader.readUInt64(true), 866464616516564)
        XCTAssertEqual(try reader.readUInt32(true), 866464616)
        XCTAssertEqual(try reader.readUInt16(true), 8664)
        XCTAssertEqual(try reader.readInt16(true), 8664)
        XCTAssertEqual(try reader.readFloat64(true), 8664.20)
        XCTAssertEqual(try reader.readFloat32(true), 866.20)
    }

    static var allTests = [
        ("testReadWrite7bitEncodedString", testReadWrite7bitEncodedString),
        ("testReadWrite7bitEncodedStringMulti", testReadWrite7bitEncodedStringMulti),
        ("testReadWriteStringEncoding", testReadWriteStringEncoding),
        ("testReadWriteMixedString", testReadWriteMixedString),
        ("testReadWriteGeneric", testReadWriteGeneric),
        ("testReadWriteNullTerminated", testReadWriteNullTerminated),
        ("testReadWriteBit", testReadWriteBit),
        ("testUInt8BitExtension", testUInt8BitExtension),
        ("testBigEndian", testBigEndian),
    ]
}
