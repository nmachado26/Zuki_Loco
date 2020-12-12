//
//  ActivityDetailViewe.swift
//  Zuki
//
//  Created by Nicolas Machado on 11/17/20.
//

import SwiftUI

struct ActivityDetailView: View {
    
    let activity: Activity
    @EnvironmentObject var timelineState: TimelineState
    @EnvironmentObject var mapState: MapState
    
    var body: some View {
        if activity.isLocoTimelineActivity {
            GeometryReader { metrics in
                ZStack(alignment: .bottom) {
                    MapView(mapState: self.mapState, timelineState: self.timelineState)
                        .edgesIgnoringSafeArea(.all)
                    VStack(spacing: 0) {
                        NavBar()
                        Spacer()
                        HStack {
                            Spacer()
                            self.fullMapButton
                                .offset(x: 0, y: self.mapState.showingFullMap ? self.timelineHeight(for: metrics, includingSafeArea: false) : 0)
                        }
                        NavigationView {
                            ItemDetailsView(timelineItem: activity.path!)
                                .onAppear {
                                    self.mapState.selectedItems.insert(activity.path!)
                                }
                                .onDisappear {
                                    self.mapState.selectedItems.remove(activity.path!)
                                }
                        }
                        .frame(width: metrics.size.width, height: self.timelineHeight(for: metrics))
                        .offset(x: 0, y: self.mapState.showingFullMap ? self.timelineHeight(for: metrics, includingSafeArea: true) : 0)
                    }
                }
            }
            
            
            //ItemDetailsView(timelineItem: activity.path!)
            //
//            self.mapState.selectedItems.insert(item)
        }
        else {
            Text("Regular :/")
        }

    }

    func timelineHeight(for metrics: GeometryProxy, includingSafeArea: Bool = false) -> CGFloat {
        let height = metrics.size.height * self.timelineState.bodyHeightPercent
        return includingSafeArea ? height + metrics.safeAreaInsets.bottom : height
    }

    var fullMapButton: some View {
        Button(action: {
            withAnimation(.spring()) {
                self.mapState.showingFullMap.toggle()
            }
        }) {
            Image(systemName: self.mapState.showingFullMap ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color("brandSecondaryBase").opacity(0.4))
                .frame(width: 40, height: 32)
                .background(Color("background").opacity(0.88))
                .cornerRadius(6)
                .shadow(color: Color.black.opacity(0.08), radius: 3, x: 0, y: 1)
        }
        .frame(width: 80, height: 62)
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailView(activity: Activity(category: "testCategory", date: Date(), isLocoTimelineActivity: false))
    }
}
