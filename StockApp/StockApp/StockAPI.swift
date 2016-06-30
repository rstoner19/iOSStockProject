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
    
    func configureURL() -> NSURL {
        let symbols = "%22YHOO%22%2C%22AAPL%22%2C%22GOOG%22%2C%22MSFT%22"
        let baseURL = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(" + symbols + ")%0A%09%09&env=http%3A%2F%2Fdatatables.org%2Falltables.env&format=json"
        return NSURL(string: baseURL)!
    }
    
    func GET() {
        let url = self.configureURL()
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        let task = self.session.dataTaskWithRequest(urlRequest) { (data, response, error) in
            if let data = data {
                do {
                    if let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String : AnyObject] {
                        if let query = json["query"] as? [String : AnyObject], results = query["results"] as? [String : AnyObject], let quote = results["quote"] as? [AnyObject] {
                            var quotes = [Quote]()
                            for quoteJSON in quote {
                                print(quoteJSON)
                                if let quote = Quote(json: quoteJSON) {
                                    quotes.append(quote)
                                }
                                
                            }
                            print(quotes)
                        }
                    }
                } catch {}
            }
            
             // IMPLEMENT Check if there was a connection, if no connection alert user!
//            if let response = response as? NSHTTPURLResponse{
//                switch response.statusCode { //
//                case 200...299:
//                    dispatch_async(dispatch_get_main_queue(), {
//                })
//                default:
//                    dispatch_async(dispatch_get_main_queue(), {
//                    })
//                }
//            }
        }
        task.resume()
        
    }
}


