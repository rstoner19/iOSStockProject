//
//  Sort.swift
//  StockApp
//
//  Created by Rick  on 7/5/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import Foundation

protocol SortBy: class {
    
//    func sortBy(port)
}

extension SortBy {
    func percentChange(portfolio: [Quote]) -> [Quote] {
        let sorted = portfolio.sort({$0.percentChangeDouble > $1.percentChangeDouble})
        
        return sorted
    }
    
}