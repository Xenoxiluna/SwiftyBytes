# `SwiftyBytes`
[![Swift 5.X](https://img.shields.io/badge/Swift-5.X-blue.svg)](https://developer.apple.com/swift/)
[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](LICENSE)
[![Build Status](https://travis-ci.org/Xenoxiluna/SwiftyBytes.svg?branch=master)]


A binary file read/write library written in swift. It was created with the purpose of being able to somewhat easily read game data files. Its not that well thought out, but you can use it if desired!

## Usage
Write
```swift
var writeTest: BinaryWriter = BinaryWriter()
try writeTest.write7BitEncodedString("This is a test!", encoding: .ascii)
try writeTest.writeNullTerminatedString("This is my second test!", encoding: .ascii)
try writeTest.writeUInt64(866464616516564)
```

Read
```swift
var readData: BinaryReadableData = BinaryReadableData(data: writeTest.data)
var reader: BinaryReader = BinaryReader(readData)
print("\(try reader.read7BitEncodedString())")
print("\(try reader.readNullTerminatedString())")
print("\(try reader.readUInt64())")
```

## License

`SwiftyBytes` is licensed under the [MIT License](LICENSE)
