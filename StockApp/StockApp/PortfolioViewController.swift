//
//  PortfolioViewController.swift
//  StockApp
//
//  Created by Rick  on 7/1/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import UIKit

class PortfolioViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var symbolInputSelected: UISearchBar!
    
    var portfolio = Set<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setup() {
        symbolInputSelected.delegate = self
        self.tableView.reloadData()
    }
    
    //** TableView and Cell **//
    func configureCell(indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("stockListCell", forIndexPath: indexPath)
        let symbol = Store.shared.allSymbols().sort()[indexPath.row]
        print(symbol)
        cell.textLabel?.text = symbol
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print(Store.shared.symbolCount())
        return Store.shared.symbolCount()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return self.configureCell(indexPath)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let symbol = Store.shared.allSymbols().sort()[indexPath.row]
            Store.shared.remove(symbol)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    //** Search Bar **//
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if let symbol = searchBar.text {
            Store.shared.add(symbol)
            Store.shared.save(Store.ArchiveURL.path!)
            
        }
        // Confirmation animation
        let textFieldInsideSearchBar = symbolInputSelected.valueForKey("searchField") as? UITextField
        searchBar.text = "Symbol Added"
        UIView.animateWithDuration(0.75, delay: 0.0, options: .CurveEaseOut, animations: {
            textFieldInsideSearchBar?.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 1.0, blue: 0.0, alpha: 0.5)
            }) { (_) in
                searchBar.text = nil
                textFieldInsideSearchBar?.backgroundColor = UIColor.whiteColor()
                
        }
        self.tableView.reloadData()
    }
    
    @IBAction func doneButtonSelected(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
