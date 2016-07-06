//
//  DetailedViewController.swift
//  StockApp
//
//  Created by Rick  on 7/1/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController, Setup {
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    
    //Detailed Price Compenonents
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceCurrentLabel: UILabel!
    @IBOutlet weak var priceTimeLabel: UILabel!
    @IBOutlet weak var priceBidAskLabel: UILabel!
    @IBOutlet weak var priceDayHighLabel: UILabel!
    @IBOutlet weak var priceDayLowLabel: UILabel!
    @IBOutlet weak var priceDayRangeLabel: UILabel!
    @IBOutlet weak var priceYearHighLabel: UILabel!
    @IBOutlet weak var priceYearLowLabel: UILabel!
    @IBOutlet weak var priceYearRangeLabel: UILabel!
    
    
    
    var quote: Quote?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup() {
        self.priceLabel.text = "Price"
        if let quote = self.quote {
            // Main Section
            self.title = quote.company
            self.symbolLabel.text = quote.symbol
            self.currentPriceLabel.text = "$\(quote.lastPrice!)"
            
            if quote.dollarChange > 0 {
                self.priceChangeLabel.textColor = UIColor(colorLiteralRed: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
                // Image
            } else if quote.dollarChange < 0 {
                self.priceChangeLabel.textColor = UIColor(colorLiteralRed: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
            }
            self.priceChangeLabel.text = "$\(quote.dollarChange!)"
            
            //Price Section
            self.priceLabel.text = "Cur. Price: \(quote.lastPrice)"
            
        }
        
    }
    
    func setupAppearance() {
        //
    }
    
    
}
