//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdatePrice(coinManager: CoinManager, coinModel: CoinModel)
    func didFailWithError(coinManager: CoinManager, error: Error)
}

struct CoinManager {
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "00939B20-8801-46E0-B4A8-922AC8C32574"
    var delegate: CoinManagerDelegate?
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    func requestData(row: Int) {
        let currency: String = currencyArray[row]
        let url = URL(string: "\(baseURL)/\(currency)?apikey=\(apiKey)")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!) { (data, response, error) in
            if (error != nil) {
                self.delegate?.didFailWithError(coinManager: self, error: error!)
                return;
            }
            if let safeData = data {
                if let parsed = parseJSON(data: safeData, currency: currency) {
                    self.delegate?.didUpdatePrice(coinManager: self, coinModel: parsed)
                }
            }
            
        }
        task.resume()
        
    }

    func parseJSON(data: Data, currency: String) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let rate = String(format: "%.02f", decodedData.rate)
            return CoinModel(rate: rate, currency: currency)
        } catch {
            delegate?.didFailWithError(coinManager: self, error: error)
            return nil
        }
    }
    
}
