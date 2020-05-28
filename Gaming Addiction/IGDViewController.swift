//
//  ViewController.swift
//  Gaming Addiction
//
//  Created by Anish Kochhar on 28/05/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var strongDisagree: UIButton!
    @IBOutlet weak var disagree: UIButton!
    @IBOutlet weak var neitherAgreeNotDisagree: UIButton!
    @IBOutlet weak var agree: UIButton!
    @IBOutlet weak var strongAgree: UIButton!
    
    @IBOutlet weak var submitButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Designing the button aesthetics
        submitButton.backgroundColor = UIColor.init(red: 0/255, green: 122/255, blue: 1.0, alpha: 1.0)
        submitButton.layer.cornerRadius = 10.0
        submitButton.tintColor = .white
    }

    
    // MARK: Submit Button
    @IBAction func submit(_ sender: Any) {
    }
    
    
    // MARK: Radio Buttons
    @IBAction func strongDisagree(_ sender: UIButton) {
        // Simply flips the state of the button, changing the image presented
        if sender.isSelected {
            sender.isSelected = false
        } else {
            // When I select this button, all others should deslect first (because all options are mutually exclusive)
            deselectAllButtons()
            sender.isSelected = true
        }
    }

    @IBAction func disagree(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            deselectAllButtons()
            sender.isSelected = true
        }
    }
    
    @IBAction func neitherAgreeNorDisagree(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            deselectAllButtons()
            sender.isSelected = true
        }
    }
    
    @IBAction func agree(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            deselectAllButtons()
            sender.isSelected = true
        }
    }
    
    @IBAction func strongAgree(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            deselectAllButtons()
            sender.isSelected = true
        }
    }
    
    func deselectAllButtons() {
        strongDisagree.isSelected = false
        disagree.isSelected = false
        neitherAgreeNotDisagree.isSelected = false
        agree.isSelected = false
        strongAgree.isSelected = false
    }
    
}

