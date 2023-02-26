//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
  func didFailWithError(_ error: Error)
  func didUpdateCoin(coinModel: CoinModel)
}

struct CoinManager {
  var delegate: CoinManagerDelegate?
  
  let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
  let apiKey = ""
  
  let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
  
  func getCoinPrice(for currency: String) {
    let url = "\(baseURL)/\(currency)?apiKey=\(apiKey)"
    performRequest(with: url)
  }
  
  func performRequest(with urlString: String) {
    if let url = URL(string: urlString) {
      let session = URLSession(configuration: .default)
      let task = session.dataTask(with: url) { (data, response, error) in
        if error != nil {
          self.delegate?.didFailWithError(error!)
          return
        }
        
        if let safeData = data {
          if let coinModel = self.parseJSON(safeData) {
            self.delegate?.didUpdateCoin(coinModel: coinModel)
          }
        }
      }
      
      task.resume()
    }
  }
  
  func parseJSON(_ data: Data) -> CoinModel? {
    let decoder = JSONDecoder()
    do {
      let decodedData = try decoder.decode(CoinData.self, from: data)
      let currency = decodedData.asset_id_quote
      let rate = decodedData.rate
      
      let coinModel = CoinModel(currency: currency, rate: rate)
      
      return coinModel
    } catch {
      delegate?.didFailWithError(error)
      return nil
    }
  }
}
