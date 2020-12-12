//
//  ActivityLocoDetailView.swift
//  Arc Mini
//
//  Created by Nicolas Machado on 12/12/20.
//  Copyright © 2020 Matt Greenfield. All rights reserved.
//

import SwiftUI

struct ActivityLocoDetailView: View {
    let activity: Activity
    var body: some View {
        VStack{
            Text(activity.category)
        }
        .navigationBarTitle(activity.category)
    }
}

struct ActivityLocoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailView(activity: Activity(category: "testCategory", date: Date(), isLocoTimelineActivity: false))
    }
}
