//
//  AppMenu.swift
//  BinanceBar
//
//  Created by Rainbow on 2024/8/22.
//

import Factory
import SwifterSwift
import SwiftUI
import SwiftUIX

struct AllTickerView: View {
    @Injected(\.wsService) private var wsService
    @State var filterTicker: [Ticker24H] = []
    @UserStorage("x-all-pair") var allPair: [LocalPair] = []

    var body: some View {
        LazyVGrid(
            columns: [
                .flexible(alignment: .leading),
                .flexible(alignment: .trailing),
                .flexible(alignment: .trailing),
            ],
            spacing: 12
        ) {
            Group {
                Text("币种 (\(wsService.allTicker24H.count))")
                Text("最新价")
                Text("24H 涨跌")
            }
            .fontWeight(.medium)
            .foregroundStyle(.secondary)
            .padding(.bottom, 4)

            ForEach(enumerating: wsService.allTicker24H) { _, trade in
                Group {
                    Text(trade.s.uppercased())
                    Text(formattedNumber(trade.c.decimal))
                        .foregroundColor(trade.xColor)
                    Group {
                        if let statusImage = trade.xStatusImage {
                            Text(formattedPercent(trade.P.decimalOr0 / 100))
                                + Text(statusImage)
                        } else {
                            Text(formattedPercent(trade.P.decimalOr0 / 100))
                        }
                    }
                    .foregroundColor(trade.xColor)
                }
            }
        }
        .monospacedDigit()
    }
}
