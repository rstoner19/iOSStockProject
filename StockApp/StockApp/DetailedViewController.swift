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
    @IBOutlet weak var directionImage: UIImageView!
    @IBOutlet weak var percentChangeLabel: UILabel!
    
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
    // Earnings Components
    @IBOutlet weak var earningsLabel: UILabel!
    @IBOutlet weak var epsLabel: UILabel!
    @IBOutlet weak var priceEarningsLabel: UILabel!
    @IBOutlet weak var pEGrowthLabel: UILabel!
    @IBOutlet weak var eBITDALabel: UILabel!
    @IBOutlet weak var bookValueLabel: UILabel!
    @IBOutlet weak var priceSalesLabel: UILabel!
    @IBOutlet weak var currentEPSEstLabel: UILabel!
    @IBOutlet weak var nextQtrEpsLabel: UILabel!
    @IBOutlet weak var nextYrEPSLabel: UILabel!
    //Dividends
    @IBOutlet weak var dividendLabel: UILabel!
    @IBOutlet weak var dividendAmountLabel: UILabel!
    @IBOutlet weak var dividendYield: UILabel!
    @IBOutlet weak var payDateLabel: UILabel!
    
    
    
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
            self.percentChangeLabel.text = quote.percentChangeString
            
            if quote.dollarChange > 0 {
                let color = UIColor(colorLiteralRed: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
                self.percentChangeLabel.textColor = color
                self.priceChangeLabel.textColor = color
                self.directionImage.image = UIImage(named: "up.png")
            } else if quote.dollarChange < 0 {
                let color = UIColor(colorLiteralRed: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
                self.priceChangeLabel.textColor = color
                self.percentChangeLabel.textColor = color
                self.directionImage.image = UIImage(named: "down.png")
            }
            self.priceChangeLabel.text = "$\(quote.dollarChange!)"
            
            //Price Section
            self.priceLabel.text = "Price"
            self.priceCurrentLabel.text = "Current: $\(quote.lastPrice!)"
            self.priceTimeLabel.text = "\(quote.lastTradeTime)"
            self.priceBidAskLabel.text = "Bid/Ask: $\(quote.bid) / $\(quote.askPrice)"
            self.priceDayHighLabel.text = "Day High: $\(quote.daysHigh)"
            self.priceDayLowLabel.text = "Day Low: $\(quote.daysLow)"
            self.priceDayRangeLabel.text = "Day Rng: \(quote.daysRange)"
            self.priceYearLowLabel.text = "Year Low: $\(quote.yearLow)"
            self.priceYearHighLabel.text = "Year High: $\(quote.yearHigh)"
            self.priceYearRangeLabel.text = "Year Range: $\(quote.yearRange)"
            
            //Earnings Section
            self.earningsLabel.text = "Earnings"
            self.epsLabel.text = "EPS: $\(quote.earningsPerShare)"
            self.priceEarningsLabel.text = "P/E: \(quote.peRatioString)"
            self.pEGrowthLabel.text = "PEG \(quote.pEGRatio)"
            self.eBITDALabel.text = "EBITDA: \(quote.eBITDA)"
            self.bookValueLabel.text = "Book Val: \(quote.bookValue)"
            self.priceSalesLabel.text = "Price/Sales: \(quote.priceSales)"
            self.currentEPSEstLabel.text = "Cur. Yr. EPS Est: $\(quote.curYrEPSEst)"
            self.nextQtrEpsLabel.text = "Next Qtr EPS ESt: $\(quote.nextQtrEPSEst)"
            self.nextYrEPSLabel.text = "Next Yr. EPS Est: $\(quote.nextYrEPSEst)"
            
            //Dividend Section
            self.dividendLabel.text = "Dividends"
            self.dividendAmountLabel.text = "Dividend: $\(quote.dividend)"
            self.dividendYield.text = "Yield: \(quote.dividendYield)%"
            self.payDateLabel.text = "Paydate " + quote.dividendPayDate
        }
        
    }
    
    func setupAppearance() {
        //
    }
    
    
}
