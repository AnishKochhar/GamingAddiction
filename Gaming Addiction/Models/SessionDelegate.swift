//
//  SessionDelegate.swift
//  Gaming Addiction
//
//  Created by Anish Kochhar on 06/06/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import Foundation

// The protocol is used to decouple the two view controllers when handing back data to the dashboard, and prevent a strong reference cycle,
protocol SessionDelegate {
    
    func sessionMade(session: Session)
    
}
