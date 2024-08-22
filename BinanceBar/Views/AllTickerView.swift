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
    @Injected(\.webSocketProvider) private var webSocketProvider

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
                Text("币种 (\(webSocketProvider.allTicker24H.count))")
                Text("最新价")
                Text("24H 涨跌")
            }
            .fontWeight(.medium)
            .foregroundStyle(.secondary)
            .padding(.bottom, 4)

            ForEach(enumerating: webSocketProvider.allTicker24H) { _, trade in
                Group {
                    Text(trade.s.uppercased().removingSuffix("USDT"))
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
    }
}

#Preview {
    AllTickerView()
        .width(200)
}
