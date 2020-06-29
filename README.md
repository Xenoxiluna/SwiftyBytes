# `SwiftyBytes`
[![Swift 5.X](https://img.shields.io/badge/Swift-5.X-blue.svg)](https://developer.apple.com/swift/)
[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](LICENSE)
[![Build Status](https://travis-ci.org/Xenoxiluna/SwiftyBytes.svg?branch=master)](https://travis-ci.org/Xenoxiluna/SwiftyBytes)


A binary file read/write library written in swift. It was created with the purpose of being able to somewhat easily read game data files. Its not that well thought out, but you can use it if desired! 

#### NOTE: Currently this library uses Swifts Data component in some places. This may be changed in a later version.
#### NOTE 2: big endian strings are not yet supported

## Usage
Write: LittleEndian
```swift
var writeTest: BinaryWriter = BinaryWriter()
try writeTest.write7BitEncodedString("This is a test!", encoding: .ascii)
try writeTest.writeNullTerminatedString("This is my second test!", encoding: .ascii)
try writeTest.writeUInt64(866464616516564)
```

Write: BigEndian
```swift
var writeTest: BinaryWriter = BinaryWriter()
try writeTest.writeUInt64(866464616516564, bigEndian: true)
```


Read: LittleEndian
```swift
var readData: BinaryData = writeTest.data
var reader: BinaryReader = BinaryReader(readData)
print("\(try reader.read7BitEncodedString())")
print("\(try reader.readNullTerminatedString())")
print("\(try reader.readUInt64())")
```

Read: BigEndian
```swift
var readData: BinaryData = writeTest.data
var reader: BinaryReader = BinaryReader(readData)
print("\(try reader.read7BitEncodedString())")
print("\(try reader.readNullTerminatedString())")
print("\(try reader.readUInt64(true))")
```

## License

`SwiftyBytes` is licensed under the [MIT License](LICENSE)
