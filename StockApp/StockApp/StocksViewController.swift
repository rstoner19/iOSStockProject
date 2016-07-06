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
        let portfolio = Store.shared.allSymbols()
        API.shared.GET(portfolio) { (quotes) in
            if let quote = quotes {
                // WHERE YOU CAN SORT ITEMS
                let test  = self.percentChange(quote)
                self.datasource = test
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
}

