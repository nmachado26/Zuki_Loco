//
//  Goal.swift
//  Zuki
//
//  Created by Nicolas Machado on 11/17/20.
//

import Foundation

/*
 Abstract:
 The model for an individual goal.
 */

import SwiftUI
import CoreLocation

struct Goal: Hashable, Codable, Identifiable {
    let id = UUID()
    var category: String
    var goalCount: Int
    
    var currentCount: Int = 0
    var achieved : Bool = false
    var progressPercentage: Double = 0.0
    
}
