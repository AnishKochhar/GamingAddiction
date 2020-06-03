//
//  AddSessionViewController.swift
//  Gaming Addiction
//
//  Created by Anish Kochhar on 03/06/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit

class AddSessionViewController: UIViewController {
    
    // MARK: Properties
    // This array stores all of the user's devices
    var devices = ["Add Device"]
    // Store the currently selected device. By default this is "Add Device"
    var selectedDevice = "Add Device"

    @IBOutlet weak var deviceTextField: UITextField!
    @IBOutlet weak var deviceTypeTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the pickers and make them the text field's input view.
        createPickers()
        // Add the toolbars to the text views
        createDeviceToolbar()
        createDeviceTypeToolbar()
    }
    
    func createPickers() {
        // Initialise Picker, and assign delegate to self
        let devicePicker = UIPickerView()
        devicePicker.delegate = self
        // Set the text field's input view to the picker
        deviceTextField.inputView = devicePicker
        
        let deviceTypePicker = UIPickerView()
        deviceTypePicker.delegate = self
        
        deviceTypeTextField.inputView = deviceTypePicker
    }
    
    func createDeviceToolbar() {
        // Create a UI toolbar so users can dismiss the picker view
        let deviceToolbar = UIToolbar()
        deviceToolbar.sizeToFit()
        
        // Create a done button so they can leave the picker view.
        let doneButton = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(AddSessionViewController.dismissKeyboardAndChangeView))
        // Call the dismissKeyboard functiom
        
        // Add the button to the toolbar
        deviceToolbar.setItems([doneButton], animated: false)
        deviceToolbar.isUserInteractionEnabled = true
        
        
        deviceTextField.inputAccessoryView = deviceToolbar
        
     
    }
    
    func createDeviceTypeToolbar() {
         // Create a UI toolbar so users can dismiss the picker view
         let deviceTypeToolbar = UIToolbar()
         deviceTypeToolbar.sizeToFit()
         
         // Create a done button so they can leave the picker view.
         let doneButton = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(AddSessionViewController.dismissKeyboard))
         // Call the dismissKeyboard functiom
         
         // Add the button to the toolbar
         deviceTypeToolbar.setItems([doneButton], animated: false)
         deviceTypeToolbar.isUserInteractionEnabled = true
         
         
         deviceTypeTextField.inputAccessoryView = deviceTypeToolbar
    }
    
    // This is so a text view can be shown if the user wishes to add a device
    @objc func dismissKeyboardAndChangeView() {
        // Clear the picker view
        view.endEditing(true)

        if selectedDevice == "Add Device" {
            // The user has chosen to add a device
            deviceTextField.placeholder = "Click here to type"
            // nil is the default value of inputView, so changing it back to nil loads the text field normally
            deviceTextField.inputView = nil
            deviceTextField.delegate = self
            
            deviceTypeTextField.inputAccessoryView = nil
        }
    }
    // This is for the device type selection, which doesn't contain a text view.
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension AddSessionViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return devices.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return devices[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Update the selected device variable
        selectedDevice = devices[row]
    }
    
}

extension AddSessionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        devices.append(deviceTextField.text!)
        print(devices)
        return true
    }
}
