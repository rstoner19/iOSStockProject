//
//  Sort.swift
//  StockApp
//
//  Created by Rick  on 7/5/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import Foundation

protocol SortBy: class {
    
}

extension SortBy {
    
    func percentChange(portfolio: [Quote]) -> [Quote] {
        let sorted = portfolio.sort({$0.percentChangeDouble > $1.percentChangeDouble})
        return sorted
    }
    
    func biggestMovers(portfolio: [Quote]) -> [Quote] {
        let sorted = portfolio.sort({abs($0.percentChangeDouble!) > abs($1.percentChangeDouble!)})
        return sorted
    }
    
    func dividendYield(portfolio: [Quote]) -> [Quote] {
        let sorted = portfolio.sort({$0.dividendYield > $1.dividendYield})
        return sorted
    }
    
    func peRatio(portfolio: [Quote]) -> [Quote] {
        let sorted = portfolio.sort({$0.peRatioDouble < $1.peRatioDouble})
        return sorted
    }
  
}