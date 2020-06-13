//
//  CurrentRate.swift
//  ExchangeRates
//
//  Created by Andrew K on 19.05.2020.
//  Copyright © 2020 Andrew K. All rights reserved.
//

import Foundation

enum CharCodes: String, CaseIterable {
    case AUD = "AUD"
    case AZN = "AZN"
    case GBP = "GBP"
    case AMD = "AMD"
    case BYN = "BYN"
    case BGN = "BGN"
    case BRL = "BRL"
    case HUF = "HUF"
    case HKD = "HKD"
    case DKK = "DKK"
    case USD = "USD"
    case EUR = "EUR"
    case INR = "INR"
    case KZT = "KZT"
    case CAD = "CAD"
    case KGS = "KGS"
    case CNY = "CNY"
    case MDL = "MDL"
    case NOK = "NOK"
    case PLN = "PLN"
    case RON = "RON"
    case XDR = "XDR"
    case SGD = "SGD"
    case TJS = "TJS"
    case TRY = "TRY"
    case TMT = "TMT"
    case UZS = "UZS"
    case UAH = "UAH"
    case CZK = "CZK"
    case SEK = "SEK"
    case CHF = "CHF"
    case ZAR = "ZAR"
    case KRW = "KRW"
    case JPY = "JPY"
    case UnpredictedCode = "Unpredicted"
    
    init(rawValue: String) {
        switch rawValue {
        case "AUD": self = .AUD
        case "AZN": self = .AZN
        case "GBP": self = .GBP
        case "AMD": self = .AMD
        case "BYN": self = .BYN
        case "BGN": self = .BGN
        case "BRL": self = .BRL
        case "HUF": self = .HUF
        case "HKD": self = .HKD
        case "DKK": self = .DKK
        case "USD": self = .USD
        case "EUR": self = .EUR
        case "INR": self = .INR
        case "KZT": self = .KZT
        case "CAD": self = .CAD
        case "KGS": self = .KGS
        case "CNY": self = .CNY
        case "MDL": self = .MDL
        case "NOK": self = .NOK
        case "PLN": self = .PLN
        case "RON": self = .RON
        case "XDR": self = .XDR
        case "SGD": self = .SGD
        case "TJS": self = .TJS
        case "TRY": self = .TRY
        case "TMT": self = .TMT
        case "UZS": self = .UZS
        case "UAH": self = .UAH
        case "CZK": self = .CZK
        case "SEK": self = .SEK
        case "CHF": self = .CHF
        case "ZAR": self = .ZAR
        case "KRW": self = .KRW
        case "JPY": self = .JPY
        default: self = .UnpredictedCode
        }
    }
    
    static func getCodesArray() -> [String] {
        var codesArray: [String] = []
        for code in CharCodes.allCases {
            codesArray.append(code.rawValue)
        }
        return codesArray
    }
}

struct CurrentRate {
    
    let nominal: Int
    let name: String
    let value: Double
    let previous: Double
}

extension CurrentRate: JSONDecodable {
    init?(JSON: [String : AnyObject]) {
        guard let value = JSON["Value"] as? Double,
        let nominal = JSON["Nominal"] as? Int,
        let name = JSON["Name"] as? String,
        let previousNominal = JSON["Previous"] as? Double else {
                return nil
        }
        
        
        self.nominal = nominal
        self.name = name
        self.value = value
        self.previous = previousNominal
    }
}
