//
//  BitCoinRate.swift
//  ByteCoin
//
//  Created by Michael Jones on 2/26/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData : Decodable {
  // var time: Date
  // var asset_id_base: String
  var asset_id_quote: String
  var rate: Double
}
