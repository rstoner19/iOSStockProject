//
//  Sort.swift
//  StockApp
//
//  Created by Rick  on 7/5/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import Foundation

protocol SortBy: class {
    
//    func biggestMovers(inout portfolio: [Quote?]) -> [Quote?]
//    func percentChange(inout portfolio: [Quote?]) -> [Quote?]
}

extension SortBy {
    func percentChange(inout portfolio: [Quote]) -> [Quote] {
        let sorted = portfolio.sort({$0.percentChangeDouble > $1.percentChangeDouble})
        
        return sorted
    }
    
}