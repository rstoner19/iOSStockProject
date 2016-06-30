//
//  Quote.swift
//  StockApp
//
//  Created by Rick  on 6/30/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import Foundation

class Quote {
    
    let company: String
    let symbol: String
    let lastPrice: Double?
    let lastTradeTime: String
    let dollarChange: Double?
    let percentChange: String

    init?(json: AnyObject) {
        if let company = json["Name"] as? String, symbol = json["Symbol"] as? String, lastPrice = json["LastTradePriceOnly"] as? String, lastTradeTime = json["LastTradeTime"] as? String, dollarChange = json["Change"] as? String, percentChange = json["ChangeinPercent"] as? String {
            
            self.company = company
            self.symbol = symbol
            self.lastPrice = Double(lastPrice)
            self.lastTradeTime = lastTradeTime
            self.dollarChange = Double(dollarChange)
            self.percentChange = percentChange
        
        } else {
            return nil
        }
    
    }
    
    
    
}