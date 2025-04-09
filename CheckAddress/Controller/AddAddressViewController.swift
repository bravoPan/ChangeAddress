//
//  AddAddressViewController.swift
//  CheckAddress
//
//  Created by Gilbert on 4/8/25.
//  Copyright © 2025 MAC. All rights reserved.
//

import UIKit

class AddAddressViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    // MARK: - Properties
    var onSave: ((String, String, String, String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the navigation bar
        navigationItem.title = "Add Address"
        
        // Set up the Done button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = doneButton
        
        // Set up the Cancel button
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    // MARK: - Actions
    @objc func doneButtonTapped() {
        guard let street = streetTextField.text,
              let city = cityTextField.text,
              let state = stateTextField.text,
              let zipCode = zipCodeTextField.text,
              !street.isEmpty,
              !city.isEmpty,
              !state.isEmpty,
              !zipCode.isEmpty else {
            // Show alert if any field is empty
            let alert = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        // Call the save closure with the form data
        onSave?(street, city, state, zipCode)
        
        // Dismiss the view controller
        navigationController?.popViewController(animated: true)
    }
    
    @objc func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
