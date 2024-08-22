//
//  Decimal++.swift
//  BinanceBar
//
//  Created by rainbow on 2024/8/22.
//

import Foundation

extension Decimal {
    var nsDecimalNumber: NSDecimalNumber {
        NSDecimalNumber(decimal: self)
    }

    var nsNumber: NSNumber {
        NSNumber(value: nsDecimalNumber.doubleValue)
    }
}
