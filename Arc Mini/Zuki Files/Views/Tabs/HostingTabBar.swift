//
//  HostingTabBar.swift
//  Zuki
//
//  Created by Nicolas Machado on 11/17/20.
//
import SwiftUI
//import GoogleSignIn

struct HostingTabBar: View {
    
    @EnvironmentObject var timelineState: TimelineState
    @EnvironmentObject var mapState: MapState
    
    var GoogleSSOFlag: Bool
    
    private enum Tab: Hashable {
        case home
        case goals
        case activites
    }
    
    @State private var selectedTab: Tab = .home
    //@EnvironmentObject var googleDelegate: GoogleDelegate
    
    var body: some View {
        
        TabView {
            HomeView(GoogleSSOFlag: GoogleSSOFlag)
                .tabItem {
                    Image(systemName: "tv.fill")
                    Text("Home")
            }
            GoalList()
                .tabItem {
                    Image(systemName: "tv.fill")
                    Text("Goals")
            }
            ActivitiesList()
                .tabItem {
                    Image(systemName: "tv.fill")
                    Text("Activities")
            }
        }
        /*
         
         Taking out bc no Google SSO yet.
        Group {
            if GoogleSSOFlag {
                if googleDelegate.signedIn {
                    TabView {
                        HomeView(GoogleSSOFlag: GoogleSSOFlag)
                            .tabItem {
                                Image(systemName: "tv.fill")
                                Text("Home")
                        }
                        GoalList()
                            .tabItem {
                                Image(systemName: "tv.fill")
                                Text("Goals")
                        }
                        ActivitiesList()
                            .tabItem {
                                Image(systemName: "tv.fill")
                                Text("Activities")
                        }
                    }
                } else {
                    Spacer()
                    Spacer()
                    GoogleSignInButton()
                }
            }
            else {
                TabView {
                    LocoTestView()
                        .tabItem {
                            Image(systemName: "tv.fill")
                            Text("LocoTest")
                    }
                    HomeView(GoogleSSOFlag: GoogleSSOFlag)
                        .tabItem {
                            Image(systemName: "tv.fill")
                            Text("Home")
                    }
                    GoalList()
                        .tabItem {
                            Image(systemName: "tv.fill")
                            Text("Goals")
                    }
                    ActivitiesList()
                        .tabItem {
                            Image(systemName: "tv.fill")
                            Text("Activities")
                    }
                }
            }
            */
            
        }
}

struct HostingTabBar_Previews: PreviewProvider {
    static var previews: some View {
        HostingTabBar(GoogleSSOFlag: true)
    }
}
