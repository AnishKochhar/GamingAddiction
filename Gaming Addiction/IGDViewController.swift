//
//  ViewController.swift
//  Gaming Addiction
//
//  Created by Anish Kochhar on 28/05/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit

class IGDViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var strongDisagree: UIButton!
    @IBOutlet weak var disagree: UIButton!
    @IBOutlet weak var neitherAgreeNorDisagree: UIButton!
    @IBOutlet weak var agree: UIButton!
    @IBOutlet weak var strongAgree: UIButton!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    
    // MARK: Properties
    // I have stored all the questions in an array, so they can be indexed easily. It is a single array that is shared between all instances of the class, so it is static.
    static let questions = ["I often lose sleep because of long gaming sessions.",
                            "I never play games in order to feel better.",
                            "I have significantly increased the amount of time I play games over the last year",
                            "When I am not gaming I feel more irritable", "I have lost interest in other hobbies because of my gaming.",
                            "I would like to cut down my gaming time but it’s difficult to do.",
                            "I usually think about my next gaming session when I am not playing.",
                            "I play games to help me cope with any bad feelings I might have.",
                            "I need to spend increasing amounts of time engaged in playing games.",
                            "I feel sad if I am not able to play games.",
                            "I have lied to my family members because the amount of gaming I do.",
                            "I do not think I could stop gaming.",
                            "I think gaming has become the most time consuming activity in my life.",
                            "I play games to forget about whatever’s bothering me.",
                            "I often think that a whole day is not enough to do everything I need to do in-game.",
                            "I tend to get anxious if I can’t play games for any reason.",
                            "I think my gaming has jeopardized the relationship with my partner. (If n/a, select 'neither agree nor disagree')",
                            "I often try to play games less but find I cannot.",
                            "I know my main daily activity (i.e., occupation, education, homemaker, etc.) has not been negatively affected by my gaming.",
                            "I believe my gaming is negatively impacting on important areas of my life."]
    // The current question number that is to be shown
    var questionNumber = 1
    // I have stored the answers in an array as well. It is static so that there is one single answers array shared by all instantiations
    static var answers = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    // The background colour of the "Next" button
    let buttonColour = UIColor(red: 0/255, green: 122/255, blue: 1.0, alpha: 1.0)
    
    // This variable stores the current answer, so that it can be put into the answers array easily
    var currentAnswer = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if the user has done the test before. If so, they should go straight to the dashboard
        if UserDefaults.standard.bool(forKey: "TestDone") == true {
            print("we in")
            // The user should now be moved to their dashboard, which is in its own storyboard
//            let dashboardStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
//
//            // Get the View Controller from the Dashboard.storyboard
//            if let dashboardVC = dashboardStoryboard.instantiateViewController(identifier: "DashboardTabBar") as? UITabBarController {
//                print("loading")
//                // Change the root controller to the dashboard vc
//                UIApplication.shared.windows[0].rootViewController = dashboardVC
//            }
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Results") as? ResultsViewController {
                print("again, in")
                // Push the vc onto the navigation stack via a show segue
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
        
        // Set the navigation bar title
        navigationItem.title = "\(String(format:"%02d", questionNumber))"

        // Designing the button aesthetics
        submitButton.backgroundColor = buttonColour
        submitButton.layer.cornerRadius = 10.0
        submitButton.tintColor = .white
        // If we are at the final question, change the text from "Next" to "Submit"
        if questionNumber == 20 {
            submitButton.setTitle("Submit", for: .normal)
            submitButton.setTitle("Submit", for: .highlighted)
        }
        
        // Load the correct question
        questionLabel.text = IGDViewController.questions[questionNumber-1]
        
        // Check if any buttons should be enabled i.e. have they previously visited this question, and already checked a box
        reselectExistingButtons()
    }

    
    // MARK: Submit Button
    @IBAction func submit(_ sender: Any) {
        // Firstly, update the answers array
        IGDViewController.answers[questionNumber-1] = currentAnswer

        // Need to check if we are at the end of the questions
        if questionNumber == 20 {
            if IGDViewController.answers.contains(0) {
                // At least one question has been left empty, and a user cannot continue until it has been filled in
                let ac = UIAlertController(title: "Missing answers for at least one question ", message: "Please go back to question \(IGDViewController.answers.firstIndex(of: 0)! + 1) and enter your response.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                present(ac, animated: true)
            }
            // We are at end of questions, load the results page
            loadResultsPage()
            
        } else {
            // If not, create a new instance of the test screen, incrementing the question nunber
            if let vc = storyboard?.instantiateViewController(withIdentifier: "IGDViewController") as? IGDViewController {
                vc.questionNumber = self.questionNumber + 1
                
                // Push that view controller onto the navigation stack
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
    // MARK: Radio Buttons
    @IBAction func strongDisagree(_ sender: UIButton) {
        // Simply flips the state of the button, changing the image presented and reset current answer
        if sender.isSelected {
            sender.isSelected = false
            currentAnswer = 0
        } else {
            // When I select this button, all others should deslect first (because all options are mutually exclusive)
            deselectAllButtons()
            sender.isSelected = true
            currentAnswer = 1
        }
    }

    @IBAction func disagree(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            currentAnswer = 0
        } else {
            deselectAllButtons()
            sender.isSelected = true
            currentAnswer = 2
        }
    }
    
    @IBAction func neitherAgreeNorDisagree(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            currentAnswer = 0
        } else {
            deselectAllButtons()
            sender.isSelected = true
            currentAnswer = 3
        }
    }
    
    @IBAction func agree(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            currentAnswer = 0
        } else {
            deselectAllButtons()
            sender.isSelected = true
            currentAnswer = 4
        }
    }
    
    @IBAction func strongAgree(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            currentAnswer = 0
        } else {
            deselectAllButtons()
            sender.isSelected = true
            currentAnswer = 5
        }
    }
    
    // MARK: General Purpose Function
    func deselectAllButtons() {
        strongDisagree.isSelected = false
        disagree.isSelected = false
        neitherAgreeNorDisagree.isSelected = false
        agree.isSelected = false
        strongAgree.isSelected = false
        currentAnswer = 0
    }
    
    func reselectExistingButtons() {
        let value = IGDViewController.answers[questionNumber-1]
        switch value {
        case 1:
            // select "Strongly Disagree"
            strongDisagree.isSelected = true
        case 2:
            // select "Disagree"
            disagree.isSelected = true
        case 3:
            // select "Neither agree nor disagree"
            neitherAgreeNorDisagree.isSelected = true
        case 4:
            // select "Agree"
            agree.isSelected = true
        case 5:
            // select "Strongly Agree"
            strongAgree.isSelected = true
        default:
            // the value is 0, so there should be nothing selected
            break
        }
        // Update the current answer anyway (not actuall necessary, as if they make a change current answer will change, but it nice to do).
        currentAnswer = value
    }
    
    func loadResultsPage() {
        // Instantiate the Results View Controller
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Results") as? ResultsViewController {
            vc.answers = IGDViewController.answers
            // Push the vc onto the navigation stack via a show segue
            show(vc, sender: self)
        }
    }

}

