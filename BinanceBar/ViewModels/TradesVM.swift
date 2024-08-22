//
//  TradesVM.swift
//  BinanceBar
//
//  Created by rainbow on 2024/8/22.
//

import CombineExt
import Factory
import Foundation

struct Pair {
    let symbol: String
    let latestPrice: String
}

@Observable
class TradesVM {
    @ObservationIgnored
    @Injected(\.webSocketProvider) var webSocketProvider

    var allSymbol: [String] = []
    var allPair: [Pair] = []

    init() {
        allSymbol = webSocketProvider.trades.keys.sorted()
    }
}
