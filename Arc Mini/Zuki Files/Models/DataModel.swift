//
//  DataModel.swift
//  Zuki
//
//  Created by Nicolas Machado on 11/18/20.
//

import Foundation
import SwiftUI
import CoreLocation
import LocoKit

class DataModel: ObservableObject {
    
    init() {
        parseTimelineItems()
        parseActivities()
        setupData()
        countGoalProgress()
    }
    
    @Published var totalGoalPercentage: Double = 0.0
    @Published var totalGoalCount: Int = 0
    @Published var currentGoalCount: Int = 0
    
    @Published var goalData: [Goal] = [
        Goal(category: "Recycle", goalCount: 5),
        Goal(category: "Sustainable Transport", goalCount: 7),

    ]
    
    @Published var activityData: [Activity] = [
        Activity(category: "Recycle", date: Date(timeIntervalSinceNow: -2454354), isLocoTimelineActivity: false)
    ]
    
    @Published var activitySections: [Day] = []
    
    func addGoalToData(goal: Goal){
        if goalData.contains(where: { $0.category == goal.category }) {
            print("ERROR: goal already present")
        } else {
            goalData.append(goal)
        }
    }
    
    func addActivityToData(activity: Activity){
        activityData.append(activity)
        let category = activity.category
        
        if let index = goalData.firstIndex(where: { $0.category == category }){
            goalData[index].currentCount += 1
            goalData[index].progressPercentage = Double(goalData[index].currentCount)/Double(goalData[index].goalCount)
            
            updateTotalGoal()
            
            if goalData[index].progressPercentage == 1.0 {
                goalData[index].achieved = true
            }
            parseActivities() //add to sections
        }
        else {
            print("ERROR: no goal for this activity")
        }
        print("added \(activity.category) activity")
    }
    
    func parseActivities() {
        
        let activities = activityData.sorted { $0.date > $1.date } // sort in ascending order
        
        // create a DateFormatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        // We use the Dictionary(grouping:) function so that all the events are
        // group together, one downside of this is that the Dictionary keys may
        // not be in order that we require, but we can fix that
        let grouped = Dictionary(grouping: activities) { (activity: Activity) -> String in
            dateFormatter.string(from: activity.date)
        }
        
        // We now map over the dictionary and create our Day objects
        // making sure to sort them on the date of the first object in the occurrences array
        // You may want a protection for the date value but it would be
        // unlikely that the occurrences array would be empty (but you never know)
        // Then we want to sort them so that they are in the correct order
        self.activitySections = grouped.map { day -> Day in
            Day(title: day.key, activities: day.value, date: day.value[0].date)
        }.sorted { $0.date > $1.date }
    }
    
    func parseTimelineItems() {
        let dateRange = DateInterval(start: Date(timeIntervalSinceNow: -172800), end: Date(timeIntervalSinceNow: 0))
        let timelineSegment = RecordingManager.store.segment(for: dateRange)
        let displayItems = getFilteredListItems(timelineSegment: timelineSegment)
        
        for displayItem in displayItems {
            if let item = displayItem.timelineItem {
//                if let visit = item as? ArcVisit {
//
//                }
                if let path = item as? ArcPath {
                    if path.activityType == .stationary || path.activityType == .car {
                        //not worth adding path, since it is not a sustainable one
                        continue
                    }
                    let activity = Activity(title: "\(path.title) (Loco)", category: "Sustainable Transport", date: path.startDate ?? Date(timeIntervalSince1970: 0), isLocoTimelineActivity: true, path: path)
                    activityData.append(activity)
                }
            }
        }
        
    }
    
    func getFilteredListItems(timelineSegment: TimelineSegment) -> [DisplayItem] {
        var displayItems: [DisplayItem] = []
        
        var previousWasThinker = false
        for item in timelineSegment.timelineItems.reversed() {
            if item.dateRange == nil { continue }
            if item.invalidated { continue }
            
            let useThinkers = RecordingManager.store.processing || getActiveItems(timelineSegment: timelineSegment).contains(item) || item.isMergeLocked

            if item.isWorthKeeping {
                displayItems.append(DisplayItem(timelineItem: item))
                previousWasThinker = false
                
            } else if useThinkers && !previousWasThinker {
                displayItems.append(DisplayItem(thinkerId: item.itemId))
                previousWasThinker = true
            }
        }
        
        return displayItems
    }
    
    func isToday(timelineSegment: TimelineSegment) -> Bool {
        return timelineSegment.dateRange?.contains(Date()) == true
    }

    // the items inside the recorder's processing boundary
    func getActiveItems(timelineSegment: TimelineSegment) ->[TimelineItem] {
        if isToday(timelineSegment: timelineSegment), !LocomotionManager.highlander.recordingState.isSleeping, let currentItem = RecordingManager.recorder.currentItem {
            return TimelineProcessor.itemsToProcess(from: currentItem)
        }
        return []
    }
    
    func countGoalProgress() {
        for goal in goalData {
            totalGoalCount += goal.goalCount
            currentGoalCount += goal.currentCount
        }
        totalGoalPercentage = Double(currentGoalCount)/Double(totalGoalCount)
    }
    
    func setupData() {
        for activity in activityData {
            let category = activity.category
            if let index = goalData.firstIndex(where: { $0.category == category }){
                goalData[index].currentCount += 1
                goalData[index].progressPercentage = Double(goalData[index].currentCount)/Double(goalData[index].goalCount)
                
                if goalData[index].progressPercentage == 1.0 {
                    goalData[index].achieved = true
                }
            }
            else {
                print("ERROR: no goal for this activity")
            }
        }
    }

    
    func updateTotalGoal() {
        currentGoalCount += 1
        totalGoalPercentage = Double(currentGoalCount)/Double(totalGoalCount)
    }
}

struct Day: Identifiable {
    let id = UUID()
    let title: String
    let activities: [Activity]
    let date: Date
}

struct DisplayItem: Identifiable {
    var id: UUID
    var timelineItem: TimelineItem?
    
    init(timelineItem: TimelineItem? = nil, thinkerId: UUID? = nil) {
        self.timelineItem = timelineItem
        if let timelineItem = timelineItem {
            id = timelineItem.itemId
        } else {
            id = thinkerId!
        }
    }
}
