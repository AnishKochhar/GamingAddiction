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
    let devices = ["Xbox", "Play Station", "Nintendo Wii", "Nintendo Wii U", "Nintendo DS", "PSP Vita",
                    "iOS device", "Android Device",
                    "PC", "Laptop"]
    // Array of device types
    let deviceTypes = ["Console", "Mobile", "Computer", "Other"]
    // Store the currently selected device. By default this is "Xbox"
    var selectedDevice = ""
    var selectedDeviceType = ""
    // Create the hours and minutes array, for the time select picker view
    let hours = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "10+"]
    let minutes = Array(0...60)
    
    let devicePicker: UIPickerView = UIPickerView()
    let deviceTypePicker: UIPickerView = UIPickerView()

    @IBOutlet weak var deviceTextField: UITextField!
    @IBOutlet weak var deviceTypeTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the pickers and make them the text field's input view.
        createPickers()
        // Add the toolbars to the text views
        createToolbar()
        print(minutes)
    }
    
    func createPickers() {
        // Assign picker's delegate to self
        devicePicker.delegate = self
        // Set the text field's input view to the picker
        deviceTextField.inputView = devicePicker
        
        deviceTypePicker.delegate = self
        deviceTypeTextField.inputView = deviceTypePicker
    }
    
    func createToolbar() {
        // Create a UI toolbar so users can dismiss the picker view
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Create a done button so they can leave the picker view.
        let doneButton = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(AddSessionViewController.dismissKeyboard))
        // Call the dismissKeyboard functiom
        
        // Add the button to the toolbar
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        
        deviceTextField.inputAccessoryView = toolbar
        deviceTypeTextField.inputAccessoryView = toolbar
    }
    
    // Dismisses the picker view
    @objc func dismissKeyboard() {
        // The user has changed the picker view, then change the UI
        if selectedDevice != "" {
            deviceTextField.text = devices[devicePicker.selectedRow(inComponent: 0)]
        }
        if selectedDeviceType != "" {
            deviceTypeTextField.text = deviceTypes[deviceTypePicker.selectedRow(inComponent: 0)]
        }
        view.endEditing(true)
    }
}

extension AddSessionViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == devicePicker {
            // As soon as they open the picker view, the text field will be able to change (change dismissKeyboard method)
            selectedDevice = "test"
            return devices.count
        } else {
            selectedDeviceType = "test"
            return deviceTypes.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == devicePicker {
            return devices[row]
        } else {
            return deviceTypes[row]
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Update the selected device variable
        if pickerView == devicePicker {
            selectedDevice = devices[row]
        } else {
            selectedDeviceType = deviceTypes[row]
        }
        
    }
    
}
