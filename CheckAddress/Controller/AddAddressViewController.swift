//
//  AddAddressViewController.swift
//  CheckAddress
//
//  Created by ByteDance on 4/8/25.
//  Copyright © 2025 MAC. All rights reserved.
//

// AddAddressViewController.swift
import UIKit
import Foundation

protocol AddAddressDelegate: AnyObject {
    func didAddAddress(_ address: Address)
}

class AddAddressViewController: UIViewController {
    
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!

    weak var delegate: AddAddressDelegate?

    @IBAction func s(_ sender: Any) {
    }
    @IBAction func doneButtonTapped(_ sender: UIViewController) {
            // Validate input
            guard let street = streetTextField.text,
                  let city = cityTextField.text,
                  let state = stateTextField.text,
                  let zipCode = zipCodeTextField.text else {
                return
            }

            // Create Address object
            let newAddress = Address(street: street, city: city, state: state, zipCode: zipCode)

            // Pass the new address back to the previous view controller
            delegate?.didAddAddress(newAddress)

            // Dismiss the view controller
            dismiss(animated: true, completion: nil)
        }
}
