//
//  Calculator.swift
//  Tipsy
//
//  Created by Texavie Developer on 2022-05-19.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct Calculator {
    var tip: Double
    var numPeople: Int
    var totalCost: Double?
    
    func getCost() -> Double {
        return (totalCost! * tip + totalCost!)/Double(numPeople)
    }
}
