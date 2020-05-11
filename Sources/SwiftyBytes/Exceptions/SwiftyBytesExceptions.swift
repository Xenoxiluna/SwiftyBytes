//
//  SwiftyBytesExceptions.swift
//  SwityBytes
//
//  Created by Quentin Berry on 2/7/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import Foundation

public enum SwiftyBytesExceptions: Error {
    case EndofDataError
    case StringConversionError
    case ArraySizeError
    case IncorrectValueType
}
