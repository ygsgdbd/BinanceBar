//
//  Binance.swift
//  BinanceBar
//
//  Created by rainbow on 2024/8/22.
//

import Foundation
import SwiftUI

// {
//  "e": "24hrTicker",  // 事件类型
//  "E": 1672515782136, // 事件时间
//  "s": "BNBBTC",      // 交易对
//  "p": "0.0015",      // 24小时价格变化
//  "P": "250.00",      // 24小时价格变化（百分比）
//  "w": "0.0018",      // 平均价格
//  "x": "0.0009",      // 整整24小时之前，向前数的最后一次成交价格
//  "c": "0.0025",      // 最新成交价格
//  "Q": "10",          // 最新成交交易的成交量
//  "b": "0.0024",      // 目前最高买单价
//  "B": "10",          // 目前最高买单价的挂单量
//  "a": "0.0026",      // 目前最低卖单价
//  "A": "100",         // 目前最低卖单价的挂单量
//  "o": "0.0010",      // 整整24小时前，向后数的第一次成交价格
//  "h": "0.0025",      // 24小时内最高成交价
//  "l": "0.0010",      // 24小时内最低成交加
//  "v": "10000",       // 24小时内成交量
//  "q": "18",          // 24小时内成交额
//  "O": 0,             // 统计开始时间
//  "C": 1675216573749, // 统计结束时间
//  "F": 0,             // 24小时内第一笔成交交易ID
//  "L": 18150,         // 24小时内最后一笔成交交易ID
//  "n": 18151          // 24小时内成交数
// }
struct Ticker24H: Codable {
    let e: String
    let E: TimeInterval
    let s: String
    let p: String
    let P: String
    let w: String
    let x: String
    let c: String
    let Q: String
    let b: String
    let B: String
    let a: String
    let A: String
    let o: String
    let h: String
    let l: String
    let v: String
    let q: String
    let O: TimeInterval
    let C: TimeInterval
    let F: Int
    let L: Int
    let n: Int
}

extension Ticker24H {
    var xColor: Color? {
        if P.decimalOr0 > 0 { return .red }
        if P.decimalOr0 < 0 { return .green }
        return nil
    }

    var xStatusImage: Image? {
        if P.decimalOr0 > 0 { return Image(systemName: .arrowUp) }
        if P.decimalOr0 < 0 { return Image(systemName: .arrowDown) }
        return nil
    }
}
