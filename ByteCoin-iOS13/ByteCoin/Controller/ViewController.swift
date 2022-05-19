//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
         
    @IBOutlet weak var pickerLabel: UIPickerView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerLabel.dataSource = self
        pickerLabel.delegate = self
        coinManager.delegate = self
    }


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.requestData(row: row)
    }
}

//MARK: - CoinManagerDelegate

extension ViewController : CoinManagerDelegate {
    func didUpdatePrice(coinManager: CoinManager, coinModel: CoinModel) {
        DispatchQueue.main.async {
            self.priceLabel.text = coinModel.rate
            self.currencyLabel.text = coinModel.currency
        }
    }
    
    func didFailWithError(coinManager: CoinManager, error: Error) {
        print(error)
    }
    
}
