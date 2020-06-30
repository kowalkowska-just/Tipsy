//
//  CalculatorViewController.swift
//  Tipsy
//
//  Created by Justyna Kowalkowska on 23/04/2020.
//  Copyright © 2020 Justyna Kowalkowska. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var numberOfPeople = 2
    var tip = 0.10
    var finalResult = "0.0"
    var billTotal = 0.0
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
        let buttonTitle = sender.currentTitle!
        let buttonTitleWithoutPercentSing = String(buttonTitle.dropLast())
        let buttonTitleAsANumber = Double(buttonTitleWithoutPercentSing)!
        tip = buttonTitleAsANumber / 100
        
        billTextField.endEditing(true)
    }
    
    @IBAction func stopperValueChanged(_ sender: UIStepper) {
        sender.minimumValue = 2
        sender.maximumValue = 12

        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
        
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {

        let bill = billTextField.text!
        if bill != "" {
            billTotal = Double(bill)!
            let result = billTotal * (1 + tip) / Double(numberOfPeople)
            finalResult = String(format: "%.2f", result)
        }
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "goToResult" {
            
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.split = numberOfPeople
            destinationVC.result = finalResult
            destinationVC.tip = Int(tip * 100)
        }
    }
}

