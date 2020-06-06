//
//  WelcomeViewController.swift
//  Gaming Addiction
//
//  Created by Anish Kochhar on 01/06/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.removeObject(forKey: "TestDone")
        UserDefaults.standard.removeObject(forKey: "TestAnswers")
        UserDefaults.standard.removeObject(forKey: "SessionsArray")

        // Check if the user has done the test before. If so, they should go straight to the dashboard
        if UserDefaults.standard.bool(forKey: "TestDone") == true {
            // The user should now be moved to their dashboard, which is in its own storyboard
            let dashboardStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)

            // Get the View Controller from the Dashboard.storyboard
            if let dashboardVC = dashboardStoryboard.instantiateViewController(identifier: "DashboardTabBar") as? UITabBarController {
                // Change the root controller to the dashboard vc
                UIApplication.shared.windows[0].rootViewController = dashboardVC
            }
        }
    }
}
