//
//  StockAPI.swift
//  StockApp
//
//  Created by Rick  on 6/30/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import Foundation

class API {
    
    static let shared = API()
    
    private let session: NSURLSession

    private init() {
        self.session = NSURLSession(configuration: .defaultSessionConfiguration())
    }
    
    private func symbolsForURL(symbols: Set<String>) -> String {
        let sortedSymbols = symbols.sort()
        var URLString = String()
        for count in 0..<sortedSymbols.count - 1 {
            URLString += "%22\(sortedSymbols[count])%22%2C"
        }
        URLString += "%22\(sortedSymbols.last!)%22"
        return URLString
    }
    
    private func configureURL() -> NSURL {
        var symbols = Store.shared.allSymbols()
        if symbols.isEmpty{
            symbols = ["^GSPC", "^IXIC"]
        }
        let symbolURL = self.symbolsForURL(symbols)
        let baseURL = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(" + symbolURL + ")%0A%09%09&env=http%3A%2F%2Fdatatables.org%2Falltables.env&format=json"
        return NSURL(string: baseURL)!
    }
    
    func GET(completion: (quotes: [Quote]?) -> ()) {
        let url = self.configureURL()
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        let task = self.session.dataTaskWithRequest(urlRequest) { (data, response, error) in
            if let error = error {
                print(error)
            }
            
            if let data = data {
                do {
                    if let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String : AnyObject] {
                        if let query = json["query"] as? [String : AnyObject], results = query["results"] as? [String : AnyObject], let quote = results["quote"] as? [AnyObject] {
                            var quotes = [Quote]()
                            for quoteJSON in quote {
                                if let quote = Quote(json: quoteJSON) {
                                    quotes.append(quote)
                                }
                            }
                            self.returnOnMain(quotes, completion: completion)
                        }
                    }
                } catch {
                    self.returnOnMain(nil, completion: completion)
                }
            }
            
        }
        task.resume()
    }
    
    
    private func returnOnMain(quotes: [Quote]?, completion: (quotes: [Quote]?) -> ()) {
        dispatch_async(dispatch_get_main_queue()) { 
            completion(quotes: quotes)
        }
    }
}


