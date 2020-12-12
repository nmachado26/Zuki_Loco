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
                    Text("\(hour):\(minute)")
                        .fontWeight(.medium)
                        .foregroundColor(Color.black)
                }
                else{
                    Text("No Date")
                }
                Spacer().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .leading)
                Text(activity.category)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .frame(alignment: .leading)
                Spacer()
            }.padding()
        }
    }
}




struct ActivityListRow_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListRow(activity: Activity(category: "Recycle", date: Date(), isLocoTimelineActivity: false))
    }
}
