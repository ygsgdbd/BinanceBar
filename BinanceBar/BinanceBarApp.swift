//
//  BinanceBarApp.swift
//  BinanceBar
//
//  Created by Rainbow on 2024/8/22.
//

import Atlantis
import Factory
import SwiftUI
import SwiftUIX

struct Subscription: Codable {
    let method: String
    let params: [String]
    let id: UInt
}

@main
struct BinanceBarApp: App {
    @Injected(\.webSocketProvider) var webSocketProvider

    init() {
        Atlantis.start(hostName: "guans-mac-mini.local.")
        webSocketProvider.connect()
    }

    var body: some Scene {
        MenuBarExtra("Binance") {
            AppMenu()

            Button {
                let msg = Subscription(
                    method: "SUBSCRIBE",
                    params: ["btcusdt@aggTrade", "btcusdt@depth"],
                    id: 1
                )
                if let data = try? JSONEncoder().encode(msg),
                   let jsonStr = data.string(encoding: .utf8)
                {
                    webSocketProvider.sendMsg(jsonStr)
                }
            } label: {
                Text("Send Message")
            }
        }
        .menuBarExtraStyle(.window)

        WindowGroup {
            ContentView()
                .onAppear {}
        }
    }
}
