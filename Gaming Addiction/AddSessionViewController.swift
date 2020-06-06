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
    let devices = ["Xbox", "Play Station", "Nintendo Console",
                    "iOS device", "Android Device",
                    "PC", "Laptop",
                    "Other"]
    // Array of device types
    let deviceTypes = ["Console", "Mobile", "Computer", "Other"]
    // Store the currently selected device. By default this is "Xbox"
    var selectedDevice = ""
    var selectedDeviceType = ""
    var timeSpentMinutes = 0
    // Create the hours and minutes array, for the time select picker view
    let hours = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11+"]
    let minutes = ["0", "15", "30", "45"]
    
    let devicePicker: UIPickerView = UIPickerView()
    let deviceTypePicker: UIPickerView = UIPickerView()
    let timePicker = UIPickerView()
    
    // MARK: Delegate Reference
    var delegate: SessionDelegate?
    

    // MARK: Outlets
    @IBOutlet weak var deviceTextField: UITextField!
    @IBOutlet weak var deviceTypeTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var addSession: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the pickers and make them the text field's input view.
        createPickers()
        // Add the toolbars to the text views
        createToolbar()
        
        // For the time picker view, there should be labels at the top to describe each component (e.g hours and minutes)
        addLabelsToTimePicker()
        
    }
    
    func addLabelsToTimePicker() {
        let labelWidth = self.view.frame.width / 2.0
        let hourLabel = UILabel(frame: CGRect(x: timePicker.frame.origin.x, y: 20, width: labelWidth, height: 30))
        hourLabel.text = "Hours"
        hourLabel.textAlignment = .center
        timePicker.addSubview(hourLabel)
        
        let minLabel = UILabel(frame: CGRect(x: timePicker.frame.origin.x + labelWidth, y: 20, width: labelWidth, height: 30))
        minLabel.text = "Minutes"
        minLabel.textAlignment = .center
        timePicker.addSubview(minLabel)
    }
    
    func createPickers() {
        // Assign picker's delegate to self
        devicePicker.delegate = self
        // Set the text field's input view to the picker
        deviceTextField.inputView = devicePicker
        
        deviceTypePicker.delegate = self
        deviceTypeTextField.inputView = deviceTypePicker
        
        timePicker.delegate = self
        timeTextField.inputView = timePicker
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
        
        let timeToolbar = UIToolbar()
        timeToolbar.sizeToFit()
        
        let timeDoneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddSessionViewController.dismissTimeKeyboard))
        
        timeToolbar.setItems([timeDoneButton], animated: false)
        timeToolbar.isUserInteractionEnabled = true
        
        
        timeTextField.inputAccessoryView = timeToolbar
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
    
    @objc func dismissTimeKeyboard() {
        let hour = timePicker.selectedRow(inComponent: 0)
        let minute = minutes[timePicker.selectedRow(inComponent: 1)]
        timeSpentMinutes = hour*60 + Int(minute)!
        if hour == 11 {
            timeTextField.text = "\(timeSpentMinutes) minutes+"
        } else {
            timeTextField.text = "\(timeSpentMinutes) minutes"
        }
        view.endEditing(true)
    }
    
    // MARK: Button actions
    @IBAction func addSession(_ sender: Any) {
        // Check that they have entered values in all fields
        if (timeTextField.text! == "") || (deviceTextField.text! == "") || (deviceTypeTextField.text! == "") {
            // They have left at least one field empty
            let ac = UIAlertController(title: "Empty fields", message: "You have left a field empty", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(ac, animated: true)
        } else {
            // Create a new session with the input values
            let newSession = Session(date: Date(), deviceUsed: selectedDevice, deviceType: selectedDeviceType, timeSpentInMinutes: timeSpentMinutes)
            
            delegate?.sessionMade(session: newSession)
            
            // Unwind back to dashboard vc
            self.navigationController?.popViewController(animated: true)
        }

    }
    
    
}

// Here is the Picker View logic as an extension to the normal viewcontroller.
// It is partially difficult to read as I have 3 picker views, each with different data sources etc., and I was the the verge of creating seperate classes to act as the delegates for each picker view, and if I had 4 I certainly would've. However, I decided against it for now, as at least all the logic is all in one place.

extension AddSessionViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == timePicker {
            return 2
        } else {
             return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == devicePicker {
            // As soon as they open the picker view, the text field will be able to change (change dismissKeyboard method)
            selectedDevice = "test"
            return devices.count
        } else if pickerView == deviceTypePicker {
            selectedDeviceType = "test"
            return deviceTypes.count
        } else {
            // It's the time picker view, which has two components
            if component == 0 {
                return hours.count
            } else {
                return minutes.count
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == devicePicker {
            return devices[row]
        } else if pickerView == deviceTypePicker {
            return deviceTypes[row]
        } else {
            if component == 0 {
                return hours[row]
            } else {
                return String(minutes[row])
            }
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Update the selected device variable
        if pickerView == devicePicker {
            selectedDevice = devices[row]
        } else if pickerView == deviceTypePicker {
            selectedDeviceType = deviceTypes[row]
        }
        
    }
    
}
