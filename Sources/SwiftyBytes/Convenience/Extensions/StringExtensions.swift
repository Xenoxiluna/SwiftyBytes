//
//  StringExtensions.swift
//  SwityBTest
//
//  Created by Quentin Berry on 5/8/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import Foundation

extension String {
    func nullTerminated(using encoding: String.Encoding) -> Data? {
        if var data = self.data(using: encoding) {
            data.append(0)
            return data
        }
        return nil
    }
}
