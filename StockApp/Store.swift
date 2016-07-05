//
//  Store.swift
//  StockApp
//
//  Created by Rick  on 7/4/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import Foundation

class Store: StoreProtocol {
    
    static let shared = Store()
    var symbols = Set<String>()
    
    private init() {
        if let storedItems = NSKeyedUnarchiver.unarchiveObjectWithFile(Store.ArchiveURL.path!) as? Set<String> {
            self.symbols = storedItems
        } else {
            self.symbols = Set<String>()
        }
    }
    
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("symbols")
    
    
}