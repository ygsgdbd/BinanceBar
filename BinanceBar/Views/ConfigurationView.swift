//
//  ConfigurationView.swift
//  BinanceBar
//
//  Created by rainbow on 2024/8/22.
//

import SwifterSwift
import SwiftUI
import SwiftUIX
import Factory

struct ConfigurationView: View {
    @State var appState = Container.shared.appState.resolve()
    @Environment(\.openWindow) var openWindow

    var body: some View {
        HStack {
            Link("binance.com", destination: "https://binance.com".url!)

            Spacer()

            Button {
                appState.tickerManagaeOpen.toggle()
                openWindow(id: "Setting")
            } label: {
                Image(systemName: .gear)
            }

            Button {
                NSApplication.shared.terminate(nil)
            } label: {
                Text("退出 ⌘ Q")
            }
            .keyboardShortcut(KeyEquivalent("q"), modifiers: .command, localization: KeyboardShortcut.Localization.automatic)
        }
    }
}

#Preview {
    ConfigurationView()
        .width(300)
        .height(200)
}
