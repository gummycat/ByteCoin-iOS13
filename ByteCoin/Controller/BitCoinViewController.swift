//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class BitCoinViewController: UIViewController {
  
  var coinManager = CoinManager()
  
  @IBOutlet weak var bitcoinLabel: UILabel!
  @IBOutlet weak var currencyLabel: UILabel!
  @IBOutlet weak var currencyPicker: UIPickerView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    currencyPicker.dataSource = self
    currencyPicker.delegate = self
    coinManager.delegate = self
  }
  
}

// MARK: - UIPickerViewDataSource

extension BitCoinViewController : UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return coinManager.currencyArray.count
  }
}

// MARK: - UIPickerViewDelegate

extension BitCoinViewController : UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    coinManager.currencyArray[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let currency = coinManager.currencyArray[row]
    coinManager.getCoinPrice(for: currency)
  }
}

// MARK: - CoinManagerDelegate

extension BitCoinViewController : CoinManagerDelegate {
  func didFailWithError(_ error: Error) {
    print(error)
  }
  
  func didUpdateCoin(coinModel: CoinModel) {
    DispatchQueue.main.async {
      self.bitcoinLabel.text = coinModel.rateString
      self.currencyLabel.text = coinModel.currency
    }
  }
}
