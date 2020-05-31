//
//  ResultsViewController.swift
//  Gaming Addiction
//
//  Created by Anish Kochhar on 29/05/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var salienceScore: UILabel!
    @IBOutlet weak var moodScore: UILabel!
    @IBOutlet weak var toleranceScore: UILabel!
    @IBOutlet weak var withdrawalScore: UILabel!
    @IBOutlet weak var conflictScore: UILabel!
    @IBOutlet weak var relapseScore: UILabel!
    @IBOutlet weak var totalScore: UILabel!
    
    // MARK: Properties
    var salience = 0.0
    var moodModification = 0.0
    var tolerance = 0.0
    var withdrawal = 0.0
    var conflict = 0.0
    var relapse = 0.0
    
    // The answers array will be passed through the segue, but currently is an empty array
    var answers = [Int]()
    
    // Remove the navigation bar before the view loads
    override func viewWillAppear(_ animated: Bool) {
           // Call the superclass viewWillAppear
           super.viewWillAppear(animated)
           
           // Disable the nav bar, as the user should not be able to navigate back to the test.
           navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        answers = [3, 4, 1, 2, 4, 2, 5, 1, 5, 3, 2, 1, 3, 4, 4, 5, 1, 3, 4, 2]
        // If the answers array was not passed correctly through the segue, then through a fatal error.
        if answers == [] {
            fatalError("The answers have not been passed to the results page")
        }
        // Flips the result for the 2nd and 19th question, as they are meant to be score reveresly
        answers[1] = 6 - answers[1]
        answers[18] = 6 - answers[18]

        calculateResults()
        
        // Update the labels with the correct scores
        salienceScore.text = String(format: "%.2f", salience)
        moodScore.text = String(format: "%.2f", moodModification)
        toleranceScore.text = String(format: "%.2f", tolerance)
        withdrawalScore.text = String(format: "%.2f", withdrawal)
        conflictScore.text = String(format: "%.2f", conflict)
        relapseScore.text = String(format: "%.2f", relapse)
        
        totalScore.text = "Your total score: \(String(answers.reduce(0, +)))"
        
        // Set up User Defaults
        let defaults = UserDefaults.standard
        // Store the answers, as well as a bool checking that the test is done, so they can't retake
        defaults.set(answers, forKey: "TestAnswers")
        defaults.set(true, forKey: "TestDone")
    }
        
   
    /* Just so anyone reading understands, each of the questions asked in the IGD-20 test fits in one of the
       following 6 dimensions, which are the 6 strands of the Griffiths' model of addiction.
     They are:
                Salience: 1, 7, 13
                Mood Modification: 2R, 8, 14
                Tolerance: 3, 9, 15
                Withdrawal symptoms: 4, 10, 16
                Conflict: 5, 11, 17, 19R, 20
                Relapse: 6, 12, 18
     n.b. the 'R' questions are scored reversely
    */
    
    func calculateResults() {
        // Quickly check that answers is not a blank array
        guard answers != [] else { fatalError("Answers in an empty array") }
        print(answers)
        
        // Calculate the factor's values by averaging all of the factors
        salience = Double(answers[0] + answers[6] + answers[12]) / 3.0

        moodModification = Double(answers[1] + answers[7] + answers[13]) / 3.0

        tolerance = Double(answers[2] + answers[8] + answers[14]) / 3.0

        withdrawal = Double(answers[3] + answers[9] + answers[15]) / 3.0

        conflict = Double(answers[4] + answers[10] + answers[16] + answers[18] + answers[19]) / 5.0
        
        relapse = Double(answers[5] + answers[11] + answers[17]) / 3.0
    }

    @IBAction func done(_ sender: Any) {
        // The user should now be moved to their dashboard, which is in its own storyboard
        let dashboardStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        
        // Get the View Controller from the Dashboard.storyboard
        if let dashboardVC = dashboardStoryboard.instantiateViewController(identifier: "DashboardTabBar") as? UITabBarController {
            // Change the root controller to the dashboard vc
            UIApplication.shared.windows[0].rootViewController = dashboardVC
        }
    }
}
