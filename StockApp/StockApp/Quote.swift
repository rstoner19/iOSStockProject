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
    let daysHigh: String
    let daysLow: String
    let daysRange: String
    let yearHigh: String
    let yearLow: String
    let yearRange: String
    let bid: String
    let askPrice: String
    
    
    let peRatioDouble: Double
    let dividendYield: Double

    init?(json: AnyObject) {
        if let company = json["Name"] as? String, symbol = json["Symbol"] as? String, lastPrice = json["LastTradePriceOnly"] as? String, lastTradeTime = json["LastTradeTime"] as? String, dollarChange = json["Change"] as? String, percentChange = json["ChangeinPercent"] as? String {
            let peRatio = json["PERatio"] as? String
            let dividendYield = json["DividendYield"] as? String
            let dayHigh = json["DaysHigh"] as? String
            let dayLow = json["DaysLow"] as? String
            let dayRange = json["DaysRange"] as? String
            let yearHigh = json["YearHigh"] as? String
            let yearLow = json["YearLow"] as? String
            let yearRange = json["YearRange"] as? String
            let bid = json["Bid"] as? String
            let askPrice = json["Ask"] as? String

            
            self.company = company
            self.symbol = symbol
            self.lastPrice = round(Double(lastPrice)!*100)/100
            self.lastTradeTime = lastTradeTime
            self.dollarChange = round(Double(dollarChange)! * 100)/100
            self.percentChangeString = percentChange
            self.percentChangeDouble = Double(self.dollarChange! / self.lastPrice!)
            self.peRatioString = peRatio
            
            if let peRatio = peRatio {self.peRatioDouble = Double(peRatio)!} else { self.peRatioDouble = 9999.9 }
            if let dividendYield = dividendYield {self.dividendYield = Double(dividendYield)!} else {self.dividendYield = 0.00 }
            if let daysHigh = dayHigh {self.daysHigh = daysHigh } else { self.daysHigh = " - " }
            if let daysLow = dayLow {self.daysLow = daysLow } else { self.daysLow = " - " }
            if let daysRange = dayRange {self.daysRange = daysRange } else { self.daysRange = " - " }
            if let yearHigh = yearHigh {self.yearHigh = yearHigh } else { self.yearHigh = " - " }
            if let yearLow = yearLow { self.yearLow = yearLow } else { self.yearLow = " - " }
            if let yearRange = yearRange { self.yearRange = yearRange } else {self.yearRange = " - " }
            if let bid = bid { self.bid = bid } else {self.bid = " - " }
            if let ask = askPrice { self.askPrice = ask } else { self.askPrice = " - " }
            
        
        } else {
            return nil
        }
    
    }
    
}