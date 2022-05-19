//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Texavie Developer on 2022-05-18.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController : UIViewController {
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!

    var numPeople: Int = 1
    var tipPercentage: Double = 1
    var splitCost: Double = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalLabel.text = String(splitCost)
        settingsLabel.text = "Split between \(numPeople) and tip of \(Int(tipPercentage * 100))%"
    }
    @IBAction func recalculatePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
