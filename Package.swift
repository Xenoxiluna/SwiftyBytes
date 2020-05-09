// swift-tools-version:5.0
//
//  Package.swift
//  SwityBytes
//
//  Created by Quentin Berry on 5/6/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "SwiftyBytes",
    products: [
        .library(name: "SwiftyBytes", targets: ["SwiftyBytes"]),
    ],
    targets: [
        .target(name: "SwiftyBytes", dependencies: []),
        .testTarget(name: "SwiftyBytesTests", dependencies: ["SwiftyBytes"]),
    ]
)
