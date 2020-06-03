//
//  Session.swift
//  Gaming Addiction
//
//  Created by Anish Kochhar on 03/06/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import Foundation

enum deviceType {
    case console
    case mobile
    case computer
    case other
}

struct Session {
    
    let deviceUsed: String
    let deviceType: deviceType
    let timeSpentInHours: Int
    
}
