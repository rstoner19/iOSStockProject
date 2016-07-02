//
//  DetailedViewController.swift
//  StockApp
//
//  Created by Rick  on 7/1/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController, Setup {
    
    
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
        if let quote = self.quote {
            self.title = quote.company
        }
        
    }
    
    func setupAppearance() {
        //
    }
    
    
}
