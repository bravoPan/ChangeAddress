// AddAddressViewController.swift
import UIKit

class AddAddressViewController: UIViewController {
    
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!

    weak var delegate: AddAddressDelegate?

    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
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