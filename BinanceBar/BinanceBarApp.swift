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

@main
struct BinanceBarApp: App {
    init() {
        Atlantis.start(hostName: "guans-mac-mini.local.")
        Container.shared.webSocketProvider.callAsFunction().connect()
    }

    var body: some Scene {
        MenuBarExtra("Binance") {
            AppMenu()
        }
        .menuBarExtraStyle(.window)

        WindowGroup {
            ContentView()
                .onAppear {
                    
                }
        }
    }
}
