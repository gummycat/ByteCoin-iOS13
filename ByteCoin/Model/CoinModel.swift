//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Michael Jones on 2/26/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
  let currency: String
  let rate: Double
  
  var rateString: String {
    return String(format: "%.3f", rate)
  }
}
