//
//  GoalListRow.swift
//  Zuki
//
//  Created by Nicolas Machado on 11/17/20.
//

import SwiftUI


struct GoalListRow: View {
    
    var goal: Goal
    var body: some View {
        NavigationLink(
            destination: GoalDetailView(goal: goal)) {
            VStack(alignment: .leading) {
                HStack {
                    Text(goal.category).foregroundColor(.blue)
                    Spacer()
                    let percentage = goal.progressPercentage*100
                    Text("\(percentage, specifier: "%.0f")%")
                    //Text("\(percentage.truncate(places: 2))%")
                }
                
                HStack {
                    Text("\(goal.currentCount)")
                    ProgressBar(value: goal.progressPercentage).frame(height: 20)
                    Spacer()
                    Text("\(goal.goalCount)")
                }.padding(.bottom,10)
            }.padding()
        }
    }
}

struct ProgressBar: View {
    var value: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color.init(hex: "CDCDCD"))
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color.init(hex: "62D7A9"))
                    .animation(.linear)
            }.cornerRadius(45.0)
        }
    }
}

struct GoalListRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GoalListRow(goal: Goal(category: "testCategory", goalCount: 1, progressPercentage: 0.7845))
        }
    }
}
