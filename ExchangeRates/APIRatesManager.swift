//
//  APIRatesManager.swift
//  ExchangeRates
//
//  Created by Andrew K on 22.05.2020.
//  Copyright © 2020 Andrew K. All rights reserved.
//

import Foundation

final class APIRatesManager: APIManager {
    
    let sessionConfiguration: URLSessionConfiguration
    lazy var session: URLSession = {
        return URLSession(configuration: self.sessionConfiguration)
    } ()
    
    init(sessionConfiguration: URLSessionConfiguration) {
        self.sessionConfiguration = sessionConfiguration
    }
    
    convenience init() {
        self.init(sessionConfiguration: URLSessionConfiguration.default)
    }
    
    func fetchCurrentRateWith(charCode: CharCodes, completionHandler: @escaping (APIResult<CurrentRate>) -> Void) {
        let url = URL(string: "https://www.cbr-xml-daily.ru/daily_json.js")
        let request = URLRequest(url: url!)
        
        fetch(request: request, parse: { (json) -> CurrentRate? in
            if let valuteDictionary = json["Valute"] as? [String: AnyObject],
                let dictionary = valuteDictionary[charCode.rawValue] as? [String: AnyObject] {
                return CurrentRate(JSON: dictionary)
            } else {
                return nil
            }
        }, completionHandler: completionHandler)
    }
}
