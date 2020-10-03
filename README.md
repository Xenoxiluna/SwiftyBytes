# `SwiftyBytes`
[![Swift 5.X](https://img.shields.io/badge/Swift-5.X-blue.svg)](https://developer.apple.com/swift/)
[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](LICENSE)
[![Docs](http://img.shields.io/badge/read_the-docs-2196f3.svg)](https://xenoxiluna.github.io/SwiftyBytes/)
[![Build Status](https://travis-ci.org/Xenoxiluna/SwiftyBytes.svg?branch=master)](https://travis-ci.org/Xenoxiluna/SwiftyBytes)


A binary file read/write library written in swift. It was created with the purpose of being able to somewhat easily read game data files.

#### NOTE: writeString prefixes the length of the given string as a generic Int. This could cause compatibility issues on 32/64-bit systems

## Usage
Write: LittleEndian
```swift
var writeTest: BinaryWriter = BinaryWriter()
try writeTest.writeVariableLengthString("This is a test!", .ascii)
try writeTest.writeNullTerminatedString("This is my second test!", .ascii)
try writeTest.writeUInt64(866464616516564)
```

Write: BigEndian
```swift
var writeTest: BinaryWriter = BinaryWriter()
try writeTest.writeUInt64(866464616516564, bigEndian: true)
```


Read: LittleEndian
```swift
var reader: BinaryReader = BinaryReader(writeTest.data)
print("\(try reader.readVariableLengthString(.ascii))")
print("\(try reader.readNullTerminatedString(.ascii))")
print("\(try reader.readUInt64())")
```

Read: BigEndian
```swift
var reader: BinaryReader = BinaryReader(writeTest.data)
print("\(try reader.readUInt64(true))")
```

## License

`SwiftyBytes` is licensed under the [MIT License](LICENSE)
