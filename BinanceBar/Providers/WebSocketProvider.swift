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

class WebSocketProvider {
    let latestMessage = CurrentValueRelay<String?>(nil)

    private var task: URLSessionWebSocketTask?

    private func didReceiveMessage() {
        task?.receive { [self] result in
            switch result {
            case .success(let msg):
                switch msg {
                case .string(let str):
                    latestMessage.accept(str)
                default:
                    break
                }
            case .failure:
                break
            }
        }
    }
}

extension WebSocketProvider {
    func connect() {
        guard let url = "wss://stream.binance.com:9443/ws".url else { return }
        task = URLSession.shared.webSocketTask(with: url)
        task?.resume()
    }

    func sendMsg(_ msg: String) {
        task?.send(.string(msg), completionHandler: { err in
            debugPrint("\(String(describing: err))")
        })
    }
}

extension Container {
    var webSocketProvider: Factory<WebSocketProvider> {
        self {
            WebSocketProvider()
        }
        .shared
    }
}
