//
//  AddGoal.swift
//  Zuki
//
//  Created by Nicolas Machado on 11/17/20.
//

import SwiftUI

struct AddGoal: View {
    
    
    let categories = ["Recycle", "Sustainable Transport"]
    //@ObservedObject var reminder: ReminderEntity
    @EnvironmentObject var dataModel: DataModel
    
    // Form Variables
    @State private var selectedCategory = 0
    @State private var selectedCount = 0
    
    @Binding var showModal: Bool
    
    
    var body: some View {
     
        NavigationView {
        Form {
            
            
            // Emoji Picker
            Picker(selection: $selectedCategory, label: Text("Category")) {
                ForEach(0 ..< categories.count) {
                    Text(self.categories[$0])
                }
            }
            
            GoalStepperView(value: $selectedCount)

            Section() {
                Button (action: {
                    let category = self.categories[self.selectedCategory]
                    let count = self.selectedCount
                    let goal = Goal(category: category, goalCount: count) //move to inside the goalModel
                    dataModel.addGoalToData(goal: goal)
                    self.showModal = false
                }) {
                    Text("Add Goal")
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

struct AddGoal_Previews: PreviewProvider {
    static var previews: some View {
        AddGoal(showModal: .constant(true))
    }
}

struct GoalStepperView: View {
    @Binding var value: Int
    //@State private var value = 0
    let colors: [Color] = [.orange, .red, .gray, .blue, .green,
                           .purple, .pink]
    
    func incrementStep() {
        value += 1
    }
    
    func decrementStep() {
        value -= 1
        if value < 0 { value = 0 }
    }
    
    var body: some View {
        
        Stepper(onIncrement: incrementStep,
                onDecrement: decrementStep) {
            Text("Times per week: \(value)")
        }
        .padding(5)
    }
    
}
