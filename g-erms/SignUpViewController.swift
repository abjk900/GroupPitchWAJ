//
//  SignUpViewController.swift
//  g-erms
//
//  Created by Tan Wei Liang on 25/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit
import CountryPicker

class SignUpViewController: UIViewController, CountryPickerDelegate {
    @IBOutlet weak var picker: CountryPicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //get corrent country
        let locale = Locale.current
        let code = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String?
        //init Picker
        picker.countryPickerDelegate = self
        picker.showPhoneNumbers = false
        picker.setCountry(code!)
    }

    // a picker item was selected
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        //pick up anythink
        //code.text = phoneCode
    }
   
}
