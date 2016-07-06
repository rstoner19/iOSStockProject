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
            let escapedSymbol = sortedSymbols[count].stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            if let escapedSymbol = escapedSymbol {
                URLString += "%22\(escapedSymbol)%22%2C"
            }
        }
        let escapedSymbol = sortedSymbols.last!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        if let escapedSymbol = escapedSymbol {
            URLString += "%22\(escapedSymbol)%22"
        }
        return URLString
    }
    
    private func configureURL(symbols: Set<String> = Set<String>()) -> NSURL {
        let symbolURL = self.symbolsForURL(symbols)
        let baseURL = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(" + symbolURL + ")%0A%09%09&env=http%3A%2F%2Fdatatables.org%2Falltables.env&format=json"
        return NSURL(string: baseURL)!
    }
    
    func GET(symbolList: Set<String> = Set<String>(), completion: (quotes: [Quote]?) -> ()) {
        
        let url = self.configureURL(symbolList)
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        let task = self.session.dataTaskWithRequest(urlRequest) { (data, response, error) in
            if let error = error {
                print(error)
            }
            
            if let data = data {
                do {
                    if let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String : AnyObject] {
                        if symbolList.count > 1 {
                            if let query = json["query"] as? [String : AnyObject], results = query["results"] as? [String : AnyObject], let quote = results["quote"] as? [AnyObject] {
                                var quotes = [Quote]()
                                for quoteJSON in quote {
                                    if let quote = Quote(json: quoteJSON) {
                                        quotes.append(quote)
                                    }
                                }
                                self.returnOnMain(quotes, completion: completion)
                            }
                        } else {
                            if let query = json["query"] as? [String : AnyObject], results = query["results"] as? [String : AnyObject ], quote = results["quote"] {
                                var quotes = [Quote]()
                                if let quote = Quote(json: quote) {
                                    quotes.append(quote)
                                }
                                self.returnOnMain(quotes, completion: completion)
                            }
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


