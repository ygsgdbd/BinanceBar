//
//  Formatted.swift
//  BinanceBar
//
//  Created by rainbow on 2024/8/22.
//

import Foundation
import Then

func formattedNumber(_ n: Decimal?) -> String {
    if let n {
        return NumberFormatter().then {
            $0.numberStyle = .currency
            $0.currencySymbol = ""
            $0.maximumFractionDigits = 2
        }.string(from: n.nsNumber) ?? kNumberPlaceholder
    } else {
        return kNumberPlaceholder
    }
}

func formattedPercent(_ n: Decimal?) -> String {
    if let n {
        return NumberFormatter().then {
            $0.numberStyle = .percent
            $0.maximumFractionDigits = 2
            $0.minimumFractionDigits = 2
        }.string(from: n.nsNumber) ?? kNumberPlaceholder
    } else {
        return kNumberPlaceholder
    }
}
