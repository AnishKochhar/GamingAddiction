//
//  DashboardViewController.swift
//  Gaming Addiction
//
//  Created by Anish Kochhar on 31/05/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, SessionDelegate {
    
    // This is the dashboard, so there should be only 1 instantiation of it, so all properties should be static
    
    // MARK: Static Properties
    static var sessions = [Session]()
    
    // Create the date formatter for use in the table view
    let dateFormatter = DateFormatter()
    
    // MARK: Outlets
    @IBOutlet weak var consoleHours: UILabel!
    @IBOutlet weak var computerHours: UILabel!
    @IBOutlet weak var mobileHours: UILabel!
    @IBOutlet weak var otherHours: UILabel!
    @IBOutlet weak var tableView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load sessions from UserDefaults
        if let data = UserDefaults.standard.value(forKey: "SessionsArray") as? Data {
            do {
                DashboardViewController.sessions = try PropertyListDecoder().decode(Array<Session>.self, from: data) 
            }
            catch  { fatalError("Couldn't load sessions from defaults") }
        }
        print(DashboardViewController.sessions)
        
        dateFormatter.dateFormat = "dd/MM/yy"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        updateLabels()
    }
    
    // MARK: SessionDelegate Protocol Methods
    func sessionMade(session: Session) {
        DashboardViewController.sessions.append(session)
        
        // Save to UserDefaults
        UserDefaults.standard.set(try? PropertyListEncoder().encode(DashboardViewController.sessions), forKey: "SessionsArray")
        // Reload table view
        tableView.reloadData()
        updateLabels()
    }
    
    // MARK: Methods
    @IBAction func addSession(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: "AddSession") as? AddSessionViewController {
            // So that data can be passed back, make the SessionDelegate for AddSessionVC, this class.
            vc.delegate = self
            // Push it onto the navigation stack
            navigationController?.pushViewController(vc, animated: true)
        }
        else { fatalError("Couldn't load next storyboard view") }
    }
    
    func updateLabels() {
        // Updates the labels describing time spent on each device category
        var deviceDict = ["Mobile": 0, "Computer": 0, "Other": 0, "Console": 0]
        // Loop through each and sum times spent
        for session in DashboardViewController.sessions {
            deviceDict[session.deviceType]! += session.timeSpentInMinutes
        }
        consoleHours.text = "\(deviceDict["Console"]!/60) hours"
        mobileHours.text = "\(deviceDict["Mobile"]!/60) hours"
        computerHours.text = "\(deviceDict["Computer"]!/60) hours"
        otherHours.text = "\(deviceDict["Other"]!/60) hours"
        
    }
}

// Extend the original VC here, to neaten the code
extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DashboardViewController.sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionCell") as! SessionTableViewCell
        // Customise the cell
        let date = DashboardViewController.sessions[indexPath.row].date
        let device = DashboardViewController.sessions[indexPath.row].deviceUsed
        let timeSpent = DashboardViewController.sessions[indexPath.row].timeSpentInMinutes
        
        cell.setLabels(date: dateFormatter.string(from: date), device: device, timeSpent: String(timeSpent))
        
        return cell
    }
    
}
