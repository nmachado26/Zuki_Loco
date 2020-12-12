//
//  ActivityDetailViewe.swift
//  Zuki
//
//  Created by Nicolas Machado on 11/17/20.
//

import SwiftUI

struct ActivityDetailView: View {
    let activity: Activity
    var body: some View {
        VStack{
            Text(activity.category)
        }
        .navigationBarTitle(activity.category)
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailView(activity: Activity(category: "testCategory", date: Date()))
    }
}
