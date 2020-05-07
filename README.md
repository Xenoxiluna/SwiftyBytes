# `SwiftyBytes`
A binary file read/write library written in swift. This library is not that useful yet, and it was only created with the purpose of being able to somewhat easily read game data files. Its not that well though out, but you can use it if desired! There are more "complete" libraries available though. And i didnt find them until after i started working on this...

## Usage
Read
```
let data = BinaryReadableData(data: <#[UInt8] or Data()#>)
let reader = BinaryReader(data)
let pid = try reader.readUInt8()
let slot = try reader.readUInt8()
```

Write
```
TBD
```

## License

`SwiftyBytes` is licensed under the [MIT License](LICENSE)
