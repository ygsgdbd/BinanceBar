//
//  ConfigurationView.swift
//  BinanceBar
//
//  Created by rainbow on 2024/8/22.
//

import SwiftUI
import SwiftUIX
import SwifterSwift

struct ConfigurationView: View {
    var body: some View {
        HStack {
            Spacer()

            Button {
                NSApplication.shared.terminate(nil)
            } label: {
                Label("退出", icon: Image(systemName: .xmarkCircle))
            }
        }
    }
}

#Preview {
    ConfigurationView()
}
