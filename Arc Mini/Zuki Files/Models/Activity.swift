//
//  Activity.swift
//  Zuki
//
//  Created by Nicolas Machado on 11/17/20.
//

import Foundation
/*
Abstract:
The model for an individual activity.
*/

import SwiftUI
import CoreLocation

struct Activity: Hashable, Codable, Identifiable {
    let id = UUID()
    var title: String?
    var category: String
    var date: Date
    var isLocoTimelineActivity: Bool
    var path: ArcPath?
}
