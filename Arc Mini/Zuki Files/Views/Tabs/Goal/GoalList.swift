//
//  GoalList.swift
//  Zuki
//
//  Created by Nicolas Machado on 11/17/20.
// test test

//update list live - didnt work but looks good
//https://stackoverflow.com/questions/56765187/how-do-i-update-a-list-in-swiftui

import SwiftUI

struct GoalList: View {
    
    @EnvironmentObject var dataModel: DataModel
    
    //@ObservedObject var goalModel = GoalListModel()

    @State private var showAddGoal = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            NavigationView{
                List(dataModel.goalData, id: \.id) { goal in
                    GoalListRow(goal: goal)
                }
                .padding(.horizontal)
                .navigationBarTitle("Goals")
                
            }
            
            Button(action: {
                self.showAddGoal = true
            }) {
                HStack {
                    Spacer()
                    Text("New Goal")
                        .fontWeight(.bold)
                        .foregroundColor(Color.init(hex: "F4AA3C"))
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.init(hex: "F4AA3C"))
                }.sheet(isPresented: $showAddGoal) {
                    AddGoal(showModal: self.$showAddGoal)
                }
                .padding()
            }
        }
    }
}

struct GoalList_Previews: PreviewProvider {
    static var previews: some View {
        GoalList().environmentObject(DataModel())
    }
}
