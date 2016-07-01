//
//  Setup.swift
//  StockApp
//
//  Created by Rick  on 7/1/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import Foundation

protocol Setup {
    func setup()
    func setupAppearance()
}

extension Setup {
    static var id: String {
        return String(self)
    }
}