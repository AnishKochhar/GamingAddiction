//
//  ResultsViewController.swift
//  Gaming Addiction
//
//  Created by Anish Kochhar on 29/05/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    // MARK: Properties
    var salience = 0
    var moodModification = 0
    var tolerance = 0
    var withdrawal = 0
    var conflict = 0
    var relapse = 0
    
    var answers = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Flips the result for the 2nd and 19th question, as they are meant to be score reveresly
        answers[1] = 6 - answers[1]
        answers[18] = 6 - answers[18]

        calculateResults()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Call the superclass viewWillAppear
        super.viewWillAppear(animated)
        
        // Disable the nav bar, as the user should not be able to navigate back to the test.
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    /* Just so anyone reading understands, each of the questions asked in the IGD-20 test fits in one of the following 6 dimensions, which are the 6 strands of the Griffiths' model of addiction.
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
        guard answers != [] else { return }
        // Calculate the factor's values by averaging all of the factors
        print(answers)
        salience = (answers[0] + answers[6] + answers[12]) / 3
        moodModification = (answers[1] + answers[7] + answers[13]) / 3
        tolerance = (answers[2] + answers[8] + answers[14]) / 3
        withdrawal = (answers[3] + answers[9] + answers[15]) / 3
        conflict = (answers[4] + answers[10] + answers[16] + answers[18] + answers[19]) / 5
        relapse = (answers[5] + answers[11] + answers[17]) / 3
        print(salience, moodModification, tolerance, withdrawal, conflict, relapse)
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
