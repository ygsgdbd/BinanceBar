//
//  AppMenu.swift
//  BinanceBar
//
//  Created by Rainbow on 2024/8/22.
//

import SwifterSwift
import SwiftUI
import SwiftUIX

struct Latest: Identifiable {
    let id: UUID = .init()
    var symbol: String
    var latest: Decimal
    var _24Change: Decimal
    var isUp: Bool?
}

struct AppMenu: View {
    @State var latests: [Latest] = [
        Latest(symbol: "BTC", latest: Decimal(65512), _24Change: Decimal(0.12)),
        Latest(symbol: "BTC", latest: Decimal(65512), _24Change: Decimal(0.12)),
        Latest(symbol: "BTC", latest: Decimal(65512), _24Change: Decimal(0.12)),
        Latest(symbol: "BTC", latest: Decimal(65512), _24Change: Decimal(0.12)),
        Latest(symbol: "BTC", latest: Decimal(65512), _24Change: Decimal(0.12)),
        Latest(symbol: "BTC", latest: Decimal(65512), _24Change: Decimal(0.12)),
        Latest(symbol: "BTC", latest: Decimal(65512), _24Change: Decimal(0.12)),
        Latest(symbol: "BTC", latest: Decimal(65512), _24Change: Decimal(0.12)),
        Latest(symbol: "BTC", latest: Decimal(65512), _24Change: Decimal(0.12)),
    ]

    var body: some View {
        LazyVGrid(
            columns: [
                .flexible(alignment: .leading),
                .flexible(alignment: .trailing),
                .flexible(alignment: .trailing),
            ],
            spacing: 4
        ) {
            Group {
                Text("币种")
                Text("最新价")
                Text("24H 涨跌")
            }
            .fontWeight(.medium)
            .foregroundStyle(.secondary)
            .padding(.bottom, 4)

            ForEach(latests) { item in
                Group {
                    Text(item.symbol)
                    Text(item.latest.string)
                    Text(item._24Change.string)
                }
            }
        }
        .padding(.all, 12)
    }
}

#Preview {
    AppMenu()
        .width(200)
}
