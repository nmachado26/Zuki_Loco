//
//  HomeView.swift
//  Zuki
//
//  Created by Nicolas Machado on 11/17/20.
//

import SwiftUI
//import GoogleSignIn

struct HomeView: View {
    
//    @EnvironmentObject var googleDelegate: GoogleDelegate
    @EnvironmentObject var dataModel: DataModel
//    @EnvironmentObject var locoModel: LocoModel
//    @EnvironmentObject var timelineModel: TimelineModel
    @State private var showAddActivity = false
    
    
    @EnvironmentObject var timelineState: TimelineState
    @EnvironmentObject var mapState: MapState
    
    //@State private var showAddActivity = false
    //var googleSSOFlag: Bool
    var GoogleSSOFlag = false
    
    //Ch3_background
    var body: some View {
        ZStack {
            Image("Ch3_background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack(){
                Spacer()
                VStack {
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 370, height: 150)
                        VStack {
                            ZStack {
                                Rectangle()
                                    .fill(Color.init(hex: "F4AA3C"))
                                    .frame(width: 200, height: 40)
                                Text("Last Activity")
                                    .foregroundColor(Color.white)
                            }
                            if let activity = dataModel.activityData.last {
                                ActivityListRow(activity: activity)
                            }
                            else {
                                Text("No recent activities")
                            }
                        }
                    }
                    .offset(y: 15)
                    ZStack {
                        Rectangle()
                            .fill(Color.init(hex: "2C3F4F"))
                            .frame(width: 370, height: 250)
                        VStack {
                            ZStack {
                                Rectangle()
                                    .fill(Color.init(hex: "F4AA3C"))
                                    .frame(width: 200, height: 40)
                                Text("Progress")
                                    .foregroundColor(Color.white)
                            }
                            ProgressBar(value: dataModel.totalGoalPercentage).frame(height: 20).padding(20)
                            Text("\(dataModel.totalGoalPercentage * 100, specifier: "%.0f")% of weekly goals completed")
                                .foregroundColor(Color.init(hex: "CECECE"))
                        }
                    }
                }
                .padding([.leading, .trailing], 20)
            }
            .background(Color.blue.opacity(0.0))
            .offset(y: 10)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        self.showAddActivity = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color.init(hex: "F4AA3C"))
                        }.sheet(isPresented: $showAddActivity) {
                            AddActivity(showModal: self.$showAddActivity)
                        }
                        .padding()
                    }
                }.offset(x:5, y:-15)
                
            }
        }
        
        /*VStack {
         if GoogleSSOFlag {
         Text(GIDSignIn.sharedInstance().currentUser!.profile.name)
         Text(GIDSignIn.sharedInstance().currentUser!.profile.email)
         Button(action: {
         GIDSignIn.sharedInstance().signOut()
         googleDelegate.signedIn = false
         }) {
         Text("Sign Out")
         }
         }
         else {
         Text("Google Auth Flag off - no user info")
         }
         }*/
    }
}

/*
 
 @EnvironmentObject var googleDelegate: GoogleDelegate
 var body: some View {
 Group {
 if googleDelegate.signedIn {
 VStack {
 Text(GIDSignIn.sharedInstance().currentUser!.profile.name)
 Text(GIDSignIn.sharedInstance().currentUser!.profile.email)
 Button(action: {
 GIDSignIn.sharedInstance().signOut()
 googleDelegate.signedIn = false
 }) {
 Text("Sign Out")
 }
 }
 } else {
 Spacer()
 Spacer()
 GoogleSignInButton()
 }
 }
 }
 */

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(GoogleSSOFlag: true).environmentObject(DataModel())
    }
}
