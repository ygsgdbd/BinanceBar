//
//  WebSocketProvider.swift
//  BinanceBar
//
//  Created by Rainbow on 2024/8/22.
//

import Combine
import CombineExt
import Factory
import Foundation
import SwifterSwift

@Observable
class WebSocketProvider {
    var allTicker24H: [Ticker24H] = []
    var btcTicker: Ticker24H?

    @ObservationIgnored
    private var task: URLSessionWebSocketTask?
}

extension WebSocketProvider {
    private func didReceiveMessage() {
        task?.receive { [self] result in
            switch result {
            case .success(let msg):
                switch msg {
                case .string(let str):
                    shunting(str)
                default:
                    break
                }
            case .failure:
                break
            }
            didReceiveMessage()
        }
    }

    private func shunting(_ msg: String) {
        guard let data = msg.data(using: .utf8) else { return }
        guard let trade = try? JSONDecoder.shared.decode(Ticker24H.self, from: data) else { return }

        DispatchQueue.main.async { [self] in
            var oldValue = allTicker24H
            oldValue.prepend(trade)
            oldValue.removeDuplicates(keyPath: \.s)
            allTicker24H = oldValue.sorted(by: \.s)
        }
    }

    func connect() {
        if let task { return }
        guard let url = "wss://stream.binance.com:9443/ws".url else { return }
        task = URLSession.shared.webSocketTask(with: url)
        task?.resume()

        didReceiveMessage()
    }

    func sendStruct(_ data: Encodable) {
        guard let data = try? JSONEncoder().encode(data) else { return }
        guard let json = data.string(encoding: .utf8) else { return }
        sendMsg(json)
    }

    func sendMsg(_ msg: String) {
        task?.send(.string(msg), completionHandler: { err in
            if let err { debugPrint(err) }
        })
    }
}

extension Container {
    var webSocketProvider: Factory<WebSocketProvider> {
        self {
            WebSocketProvider()
        }
        .singleton
        .decorator { instance in
            instance.connect()
        }
    }
}
