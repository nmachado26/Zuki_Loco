//
//  AddActivity.swift
//  Zuki
//
//  Created by Nicolas Machado on 11/17/20.
//
import SwiftUI

struct AddActivity: View {
    
    
    let categories = ["Recycle", "Sustainable Transport"]
    //@ObservedObject var reminder: ReminderEntity
    @EnvironmentObject var dataModel: DataModel
    
    // Form Variables
    @State private var selectedCategory = 0
    @State private var selectedDate = Date()
    
    @Binding var showModal: Bool
    var body: some View {
        
        NavigationView{
            Form {
                // Emoji Picker
                Picker(selection: $selectedCategory, label: Text("Category")) {
                    ForEach(0 ..< categories.count) {
                        Text(self.categories[$0])
                    }
                }
                DatePicker(selection: $selectedDate, in: ...Date(), displayedComponents: [.date, .hourAndMinute]) {
                    Text("Date")
                }
                
                Section() {
                    Button (action: {
                        let category = self.categories[self.selectedCategory]
                        let date = self.selectedDate
                        var calendar = Calendar.current
                        let hour = calendar.component(.hour, from: date)
                        let minute = calendar.component(.minute, from: date)
                        let second = calendar.component(.second, from: date)
                        let activity = Activity(category: category, date: date, isLocoTimelineActivity: false)
                        dataModel.addActivityToData(activity: activity)
                        self.showModal = false
                    }) {
                        Text("Add Activity")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .font(.body)
                    }        .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .padding(.vertical, -6)
                    .padding(.horizontal, -15)
                }
            }
        }
        
        
        
        
    }
}

struct AddActivity_Previews: PreviewProvider {
    static var previews: some View {
        AddActivity(showModal: .constant(true))
    }
}
