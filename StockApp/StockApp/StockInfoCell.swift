//
//  StockInfoCell.swift
//  StockApp
//
//  Created by Rick  on 7/1/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import UIKit

class StockInfoCell: UITableViewCell, Setup {
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dollarChangeLabel: UILabel!
    @IBOutlet weak var percentChangeLabel: UILabel!
    
    // MAY USE IN OTHER VIEW CONTROLLER IF NOT DELETE
    func verify<T>(element: UILabel, data: T?) {
        if let data = data {
            element.text = String(data)
        }
    }
    
    var quote: Quote! {
        didSet {
            self.symbolLabel.text = quote.symbol
            self.companyLabel.text = quote.company
            if let price = quote.lastPrice {
                self.priceLabel.text = "$\(price)"
            }
            verify(self.dollarChangeLabel, data: quote.dollarChange)
            self.percentChangeLabel.text = String(format: "%.2f", quote.percentChangeDouble! * 100) + "%"
        }
    }
    
    func setup() {
        //
    }
    
    func setupAppearance() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.grayColor().CGColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAppearance()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}