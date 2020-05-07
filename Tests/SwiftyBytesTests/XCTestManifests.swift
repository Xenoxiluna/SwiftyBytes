//
//  XCTestManifests.swift
//  SwityBytes
//
//  Created by Quentin Berry on 5/6/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SwiftyBytesTests.allTests),
    ]
}
#endif
