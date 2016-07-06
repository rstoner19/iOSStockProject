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
    let percentChangeString: String
    let percentChangeDouble: Double?
    let peRatioString: String?
    
    let peRatioDouble: Double
    let dividendYield: Double

    init?(json: AnyObject) {
        if let company = json["Name"] as? String, symbol = json["Symbol"] as? String, lastPrice = json["LastTradePriceOnly"] as? String, lastTradeTime = json["LastTradeTime"] as? String, dollarChange = json["Change"] as? String, percentChange = json["ChangeinPercent"] as? String {
            let peRatio = json["PERatio"] as? String
            let dividendYield = json["DividendYield"] as? String
            print(dividendYield, peRatio)
            
            self.company = company
            self.symbol = symbol
            self.lastPrice = round(Double(lastPrice)!*100)/100
            self.lastTradeTime = lastTradeTime
            self.dollarChange = round(Double(dollarChange)! * 100)/100
            self.percentChangeString = percentChange
            self.percentChangeDouble = Double(self.dollarChange! / self.lastPrice!)
            self.peRatioString = peRatio
            
            // returns as optional string, need to get to double, is there a better way than if let since I can't force unwrap
            if let peRatio = peRatio {self.peRatioDouble = Double(peRatio)!} else { self.peRatioDouble = 9999.9 }
            if let dividendYield = dividendYield {self.dividendYield = Double(dividendYield)!} else {self.dividendYield = 0.00 }
        
        } else {
            return nil
        }
    
    }
    
}