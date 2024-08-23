//
//  TickerManageView.swift
//  BinanceBar
//
//  Created by Rainbow on 2024/8/23.
//

import SwifterSwift
import SwiftUI
import SwiftUIX
import Then

struct TickerManageView: View {
    @UserStorage("x-all-pair")
    var allPair: [LocalPair] = []

    @State var newSymbol: String = ""

    var body: some View {
        VStack {
            Table(allPair) {
                TableColumn("币种", value: \.symbol)
                TableColumn("状态") { pair in
                    Toggle(isOn: Binding(get: {
                        pair.enabled
                    }, set: { [self] value in
                        if let index = allPair.firstIndex(of: pair) {
                            allPair[index].enabled = value
                        }
                    }), label: {
                        EmptyView()
                    })
                    .toggleStyle(.switch)
                }
                TableColumn("操作") { pair in
                    Button {
                        allPair.removeAll(where: { $0 == pair })
                    } label: {
                        Text("删除")
                    }
                    .foregroundStyle(.red)
                }
            }

            Divider()

            Form {
                TextField(text: $newSymbol) {
                    Text("币种")
                }
                .textFieldStyle(.roundedBorder)

                Button {
                    if newSymbol.isWhitespace { return }
                    let newPair = LocalPair(
                        symbol: newSymbol,
                        enabled: true
                    )
                    allPair.append(newPair)
                    newSymbol = ""
                } label: {
                    Text("添加")
                }
                .submitScope()
            }
            .padding(.all, 12)
        }
        .width(480)
    }
}

#Preview {
    TickerManageView()
}
