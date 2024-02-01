//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinMG.currencyArray.count
    }
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    var dataSource: UIPickerViewDataSource!
    var coinMG = CoinManager()
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var currencyLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinMG.delegate = self
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinMG.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinMG.getCoinPrice(for: coinMG.currencyArray[row])
    }
    
    func didUpdateCurrency(_ currencyMg: CoinManager, currency: CoinData) {
        print("here")
        DispatchQueue.main.async {
            self.currencyLabel.text = currency.asset_id_quote
            self.bitcoinLabel.text = String(format: "%0.4F", currency.rate) 
        }
        
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

