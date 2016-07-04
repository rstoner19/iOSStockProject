//
//  PortfolioViewController.swift
//  StockApp
//
//  Created by Rick  on 7/1/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import UIKit

class PortfolioViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var symbolInputSelected: UISearchBar!
    
    var portfolio = Set<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        symbolInputSelected.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if let symbol = searchBar.text {
            portfolio.insert(symbol)
        }
        // Confirmation animation
        let textFieldInsideSearchBar = symbolInputSelected.valueForKey("searchField") as? UITextField
        searchBar.text = "Symbol Added"
        UIView.animateWithDuration(0.4, delay: 0.0, options: .CurveEaseOut, animations: {
            textFieldInsideSearchBar?.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 1.0, blue: 0.0, alpha: 0.5)
            }) { (_) in
                searchBar.text = nil
        }
        
        
    }
    
    
    @IBAction func doneButtonSelected(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
