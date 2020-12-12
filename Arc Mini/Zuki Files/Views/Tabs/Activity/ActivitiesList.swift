//
//  ActivitiesList.swift
//  Zuki
//
//  Created by Nicolas Machado on 11/17/20.
//

import SwiftUI

struct ActivitiesList: View {
    
    @EnvironmentObject var dataModel: DataModel
    
    @State private var showAddActivity = false
    var body: some View {
        VStack(alignment: .leading) {
            NavigationView {
                //                List(dataModel.activityData, id: \.id) { activity in
                //                    ActivityListRow(activity: activity)
                //                }
                List {
                    ForEach(dataModel.activitySections) { section in
                        Section(header: Text(section.title)) {
                            ForEach(section.activities) { activity in
                                ActivityListRow(activity: activity)
                            }
                            
                        }
                    }
                }
                .navigationBarTitle("Activities")
            }
            
            //button
            Button(action: {
                self.showAddActivity = true
            }) {
                HStack {
                    Spacer()
                    Text("New Activity")
                        .fontWeight(.bold)
                        .foregroundColor(Color.init(hex: "F4AA3C"))
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.init(hex: "F4AA3C"))
                }.sheet(isPresented: $showAddActivity) {
                    AddActivity(showModal: self.$showAddActivity)
                }
                .padding()
            }
        }
    }
}

struct ActivitiesList_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesList()
    }
}

