//
//  StoreProtocol.swift
//  StockApp
//
//  Created by Rick  on 7/4/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import Foundation


protocol StoreProtocol: class {
//    associatedtype Object: NSObject, Identity
    var symbols: Set<String> { get set }
    
    
    func add(object: String)
    func remove(object: String)
    func save(file: String)
    func allSymbols() -> Set<String>
    func symbolCount() -> Int
    
}

extension StoreProtocol {
    
    func add(symbol: String) {
        return symbols.insert(symbol)
    }
    
    func remove(symbol: String) {
        self.symbols.remove(symbol)
    }
    
    func save(file: String) {
        NSKeyedArchiver.archiveRootObject(self.symbols, toFile: file)
    }
    
    func allSymbols() -> Set<String> {
        return self.symbols
    }
    
    func symbolCount() -> Int {
        return self.symbols.count
    }

    
}
