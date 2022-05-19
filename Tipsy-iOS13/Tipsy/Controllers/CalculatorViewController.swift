//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
      
    var calculator = Calculator(tip: 10, numPeople: 2)
    
    @IBAction func tipChanged(_ sender: Any) {
        billTextField.endEditing(true)
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        let selected = sender as! UIButton
        selected.isSelected = true;
        
        var selectedTitle = selected.currentTitle!
        selectedTitle = String(selectedTitle.dropLast())
        let percentage = Double(selectedTitle)!/100
        calculator.tip = percentage
    }
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        let val = sender.value
        splitNumberLabel.text = String(format: "%.0f", val)
        let numPeople = Int(splitNumberLabel.text!)!
        calculator.numPeople = numPeople
    }
    
    @IBAction func calculatePressed(_ sender: Any) {
        if (billTextField.text != nil && billTextField.text != "") {
            calculator.totalCost = Double(billTextField.text!)
            performSegue(withIdentifier: "ResultsViewController", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsViewController" {
            let dest = segue.destination as! ResultsViewController
            dest.numPeople = calculator.numPeople
            dest.tipPercentage = calculator.tip
            dest.splitCost = round(calculator.getCost() * 100) / 100
        }
    }
    
}

