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
import SwiftUIX

@Observable
class WSService {
    var allTicker24H: [Ticker24H] = []

    @ObservationIgnored
    private var task: URLSessionWebSocketTask? = nil
}

extension WSService {
    private func didReceiveMessage() {
        task?.receive { [self] result in
            switch result {
            case .success(let msg):
                switch msg {
                case .string(let str):
                    _shunting(str)
                default:
                    break
                }
            case .failure:
                break
            }
            didReceiveMessage()
        }
    }

    private func _shunting(_ msg: String) {
        guard let data = msg.data(using: .utf8) else { return }
        guard let trade = try? JSONDecoder.shared.decode(Ticker24H.self, from: data) else { return }

        var oldValue = allTicker24H
        oldValue.prepend(trade)
        oldValue.removeDuplicates(keyPath: \.s)

        DispatchQueue.main.async { [self] in
            allTicker24H = oldValue.sorted(by: \.s)
        }
    }

    func connect() {
        guard
            let url = "wss://stream.binance.com:9443/ws".url
        else { return }

        task = URLSession.shared.webSocketTask(with: url)
        task?.resume()

        didReceiveMessage()
    }

    func sendJSON(_ data: Encodable) {
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
    var wsService: Factory<WSService> {
        self {
            WSService()
        }
        .shared
        .decorator { instance in
            instance.connect()
        }
    }
}
