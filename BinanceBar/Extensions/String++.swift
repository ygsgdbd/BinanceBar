//
//  String++.swift
//  BinanceBar
//
//  Created by rainbow on 2024/8/22.
//

import Foundation

extension String {
    var decimal: Decimal? { Decimal(string: self) }

    var decimalOr0: Decimal { decimal ?? Decimal(0) }
}
