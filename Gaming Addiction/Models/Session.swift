//
//  Session.swift
//  Gaming Addiction
//
//  Created by Anish Kochhar on 03/06/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import Foundation


struct Session: Codable {
    let date: Date
    let deviceUsed: String
    let deviceType: String
    let timeSpentInMinutes: Int
    
}
