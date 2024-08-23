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
import KeyboardShortcuts
import SwifterSwift
import SwiftUI
import SwiftUIX

@main
struct BinanceBarApp: App {
    @Injected(\.wsService) var wsService
    @State var appState = Container.shared.appState.resolve()
    @UserStorage("x-all-pair") var allPair: [LocalPair] = []

    let subscriptionId = UUID().uuidString

    init() {
        #if DEBUG
        Atlantis.start()
        #endif

        wsService.connect()
        subscription()
    }

    func subscription() {
        let tickers = allPair.filter(\.enabled).map { "\($0.symbol)usdt@ticker".lowercased() }
        if tickers.isEmpty { return }

        wsService.sendJSON(Subscription(
            id: subscriptionId,
            method: "UNSUBSCRIBE",
            params: tickers
        ))

        wsService.sendJSON(Subscription(
            id: subscriptionId,
            method: "SUBSCRIBE",
            params: tickers
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
        .onChange(of: allPair) { oldValue, newValue in
            subscription()
        }

        Window("Setting", id: "Setting") {
            TickerManageView()
        }
    }
}
