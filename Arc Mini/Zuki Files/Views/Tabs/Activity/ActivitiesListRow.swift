//
//  ActivitiesListRow.swift
//  Zuki
//
//  Created by Nicolas Machado on 11/17/20.
//

import SwiftUI

struct ActivityListRow: View {
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    // let timeZone = TimeZone(identifier: "EST")
    var activity: Activity
    var calendar = Calendar.current
    
    var body: some View {
        NavigationLink(
            destination: ActivityDetailView(activity: activity)) {
            HStack {
                if let date = activity.date {
                    let hour = calendar.component(.hour, from: date)
                    let minute = calendar.component(.minute, from: date)
                    let second = calendar.component(.second, from: date)
                    //                    if minute < 10 {
                    //                        Text("\(hour%12):\(minute)")
                    //                            .fontWeight(.medium)
                    //                            .foregroundColor(Color.black)
                    //                    }
                    //                    else {
                    //                        Text("\(hour%12):\(minute)")
                    //                            .fontWeight(.medium)
                    //                            .foregroundColor(Color.black)
                    //                    }
                    
                    let hourStr = (hour < 10 ? "0\(hour)": "\(hour)")
                    let minStr = (minute < 10 ? "0\(minute)": "\(minute)")
                    let finStr = hourStr + ":" + minStr
                    
                    
                    ZStack {
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 70, height: 40)
                            .cornerRadius(10)
                        
                        Text(finStr)
                            .fontWeight(.medium)
                            .foregroundColor(Color.white)
                    }
                    
                }
                else{
                    Text("No Date")
                }
                Spacer().frame(width: 60, alignment: .leading)
                Text(activity.title ?? activity.category)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .frame(alignment: .leading)
                Spacer()
                Text(dateRangeString)
                    .fontWeight(.regular)
                    .foregroundColor(.secondary)
                    .frame(alignment: .leading)
                
                
                
            }.padding()
        }
    }
    
    var dateRangeString: String {
        guard let timelineItem = activity.path else {
            return ""
        }
        var arcItem: ArcTimelineItem { return timelineItem as! ArcTimelineItem }
        
        guard let dateRange = timelineItem.dateRange else { return "" }
        guard let startString = arcItem.startTimeString else { return "" }

        if dateRange.start.isToday, let endString = arcItem.endTimeString {
            return String(format: "%@", dateRange.shortDurationString)
        }

        if let endDateString = arcItem.startString(dateStyle: .long, timeStyle: .none, relative: true) {
            return String(format: "%@", dateRange.shortDurationString)
        }

        return ""
    }
}




struct ActivityListRow_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListRow(activity: Activity(category: "Recycle", date: Date(), isLocoTimelineActivity: false))
    }
}
