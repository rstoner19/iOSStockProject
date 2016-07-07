//
//  ViewController.swift
//  StockApp
//
//  Created by Rick  on 6/30/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import UIKit

class StocksViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var datasource = [Quote]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupAppearance()
        setupTableView()
    }
    
    override func viewWillAppear(animated: Bool) {
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func setupTableView() {
        self.tableView.rowHeight = 50
        self.tableView.registerNib(UINib(nibName: "StockInfoCell", bundle: nil), forCellReuseIdentifier: "stockInfoCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }


}

extension StocksViewController: UITableViewDataSource, Setup, SortBy
{
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == DetailedViewController.id() {
            guard let detailedViewController = segue.destinationViewController as? DetailedViewController else { return }
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            detailedViewController.quote = self.datasource[indexPath.row]
        }
    }
    
    
    func setup() {
        if Store.shared.allSymbols().isEmpty {
            Store.shared.add("^IXIC")
            Store.shared.add("^GSPC")
        }
        let portfolio = Store.shared.allSymbols()
        
        API.shared.GET(portfolio) { (quotes) in
            if let quote = quotes {
                self.datasource = quote
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(DetailedViewController.id(), sender: nil)
    }
    
    func  setupAppearance() {
       self.title = "Portfolio"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.datasource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("stockInfoCell", forIndexPath: indexPath) as! StockInfoCell
        let quote = self.datasource[indexPath.row]
        
        cell.quote = quote
        
        if quote.percentChangeDouble > 0 {
            let red: Float = 0.0, green: Float = 1.0, blue: Float = 0.0
            let alpha: Float = 0.05 + ((Float(quote.percentChangeDouble!) / 0.02 ) / 10)
            cell.backgroundColor = UIColor(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)
        } else if quote.percentChangeDouble < 0 {
            let red: Float = 1.0, green: Float = 0.0, blue: Float = 0.0
            let alpha: Float = 0.05 + abs(((Float(quote.percentChangeDouble!) / 0.02 ) / 10))
            cell.backgroundColor = UIColor(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)
        }
        
        return cell
    }
    
    func presentSortActions(portfolio: Set<String>) {
        
        let actionSheet = UIAlertController(title: "Sort By", message: "Please select how to sort the stocks by.", preferredStyle: .ActionSheet)
        let alphabeticalAction = UIAlertAction(title: "Default (Alphabetical", style: .Default) { (action) in
            API.shared.GET(portfolio) { (quotes) in
                if let quote = quotes {
                    self.datasource = quote
                }
            }
        }
        let percentChangeAction = UIAlertAction(title: "Percent Change", style: .Default) { (action) in
            API.shared.GET(portfolio) { (quotes) in
                if let quote = quotes {
                    self.datasource = self.percentChange(quote)
                }
            }
        }
        let biggestMoverAction = UIAlertAction(title: "Biggest Mover", style: .Default) { (action) in
            API.shared.GET(portfolio) { (quotes) in
                if let quote = quotes {
                    self.datasource = self.biggestMovers(quote)
                }
            }
        }
        let dividendYieldAction = UIAlertAction(title: "Dividend Yield", style: .Default) { (action) in
            API.shared.GET(portfolio) { (quotes) in
                if let quote = quotes {
                    self.datasource = self.dividendYield(quote)
                }
            }
        }
        let peRatioAction = UIAlertAction(title: "P/E Ratio", style: .Default) { (action) in
            API.shared.GET(portfolio) { (quotes) in
                if let quote = quotes {
                    self.datasource = self.peRatio(quote)
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        actionSheet.addAction(alphabeticalAction)
        actionSheet.addAction(percentChangeAction)
        actionSheet.addAction(biggestMoverAction)
        actionSheet.addAction(dividendYieldAction)
        actionSheet.addAction(peRatioAction)
        actionSheet.addAction(cancelAction)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func sortButtonSelected(sender: AnyObject) {
        let portfolio = Store.shared.allSymbols()
        presentSortActions(portfolio)
    }
}

