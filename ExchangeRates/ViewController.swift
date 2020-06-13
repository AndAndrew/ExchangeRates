//
//  ViewController.swift
//  ExchangeRates
//
//  Created by Andrew K on 19.05.2020.
//  Copyright © 2020 Andrew K. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rateTextField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var convertLabel: UILabel!
    
    lazy var ratesManager = APIRatesManager()
    var charCodesArray = CharCodes.getCodesArray()
    var charCode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        pickerView(pickerView, didSelectRow: pickerView.selectedRow(inComponent: 0), inComponent: 0)
        
        getCurrentRates()
    }
    
    func getCurrentRates() {
        charCode = rateTextField.text!
        ratesManager.fetchCurrentRateWith(charCode: CharCodes(rawValue: charCode)) { (result) in
            switch result {
            case .Success(let currentRate):
                self.updateUIWith(currentRate: currentRate)
            case .Failure(let error as NSError):
                
                let alertController = UIAlertController(title: "Unable to get data", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func updateUIWith(currentRate: CurrentRate) {
        self.convertLabel.text = "\(currentRate.nominal) \(currentRate.name) = \(currentRate.value) RUB, предыдущий курс \(currentRate.previous) RUB"
    }

    @IBAction func convertAction(_ sender: UIButton) {
        getCurrentRates()
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return charCodesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return charCodesArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        charCode = charCodesArray[row]
        rateTextField.text = charCode
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerViewLabel = UILabel()
        
        if let currentLabel = view as? UILabel {
            pickerViewLabel = currentLabel
        } else {
            pickerViewLabel = UILabel()
        }
        pickerViewLabel.textColor = .black
        pickerViewLabel.textAlignment = .center
        pickerViewLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 23)
        pickerViewLabel.text = charCodesArray[row]
        return pickerViewLabel
    }
    
}

