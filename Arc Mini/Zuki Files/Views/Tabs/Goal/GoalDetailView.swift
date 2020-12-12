//
//  GoalDetailView.swift
//  Zuki
//
//  Created by Nicolas Machado on 11/17/20.
//

import SwiftUI

struct GoalDetailView: View {
    let goal: Goal
    var body: some View {
        VStack{
            Text(goal.category)
        }
        .navigationBarTitle(goal.category)
    }
}

struct GoalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GoalDetailView(goal: Goal(category: "Test Cat", goalCount: 2))
    }
}
