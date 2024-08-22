//
//  TickerVM.swift
//  BinanceBar
//
//  Created by rainbow on 2024/8/22.
//

import CombineExt
import Factory
import Foundation

@Observable
class TickerVM {
    @ObservationIgnored
    @Injected(\.webSocketProvider) var webSocketProvider

    init() {}
}
