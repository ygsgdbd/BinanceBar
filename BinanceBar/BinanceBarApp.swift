//
//  BinanceBarApp.swift
//  BinanceBar
//
//  Created by Rainbow on 2024/8/22.
//

#if DEBUG
import Atlantis
#endif

import Factory
import SwifterSwift
import SwiftUI
import SwiftUIX

struct Subscription: Codable, Identifiable {
    var id = UUID()
    var method: String = "SUBSCRIBE"
    let params: [String]

    init(params: [String]) {
        self.params = params
    }
}

@main
struct BinanceBarApp: App {
    @Injected(\.webSocketProvider) var webSocketProvider

    init() {
        #if DEBUG
        Atlantis.start()
        #endif

        webSocketProvider.connect()
        subscription()
    }

    func subscription() {
        guard webSocketProvider.allTicker24H.isEmpty else { return }

        webSocketProvider.sendStruct(Subscription(
            params: [
                "btcusdt@ticker",
                "ethusdt@ticker",
                "bnbusdt@ticker",
                "dogeusdt@ticker",
                "trxusdt@ticker",
                "eosusdt@ticker",
                "ltcusdt@ticker",
                "linkusdt@ticker",
            ]
        ))
    }

    var body: some Scene {
        MenuBarExtra("Binance") {
            ScrollView {
                LazyVStack(spacing: 12) {
                    AllTickerView()
                    Divider()
                    ConfigurationView()
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(.all, 12)
            .onAppear {
                subscription()
            }
        }
        .menuBarExtraStyle(.window)
    }
}
