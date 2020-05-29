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

        calculateResults()
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
        // Calculate the factor's values
        print(answers)
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
