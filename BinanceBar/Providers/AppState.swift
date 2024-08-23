//
//  AppState.swift
//  BinanceBar
//
//  Created by Rainbow on 2024/8/23.
//

import Combine
import Factory
import Foundation
import SwiftUIX

@Observable
class AppState {
    var tickerManagaeOpen: Bool = false
}

extension Container {
    var appState: Factory<AppState> {
        self {
            AppState()
        }
        .shared
    }
}
