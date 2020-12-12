//
//  VisitListBox.swift
//  Arc Mini
//
//  Created by Matt Greenfield on 10/3/20.
//  Copyright © 2020 Matt Greenfield. All rights reserved.
//

import SwiftUI
import LocoKit

struct VisitListBox: View {

    @ObservedObject var visit: ArcVisit

    @State var showDeleteAlert = false

    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 0) {
                VStack(alignment: .leading) {
                    Text(visit.startTimeString ?? "")
                        .frame(width: 72, alignment: .leading)
                        .font(.system(size: 16, weight: .medium))
                    Text(String(duration: visit.duration, style: .abbreviated))
                        .frame(width: 72, alignment: .leading)
                        .font(.system(size: 13, weight: .regular))
                }
                self.categoryImage.renderingMode(.template).foregroundColor(self.categoryColor)
                Spacer().frame(width: 24)
                Text(title).font(.system(size: 16, weight: .semibold))
                Spacer()
            }
            .padding(EdgeInsets(top: 18, leading: 20, bottom: 18, trailing: 20))
            .background(Color("background"))
            .contextMenu {
                NavigationLink(destination: VisitEditView(visit: visit, placeClassifier: visit.placeClassifier)) {
                    Text("Edit visit")
                    Image(systemName: "square.and.pencil")
                }
                if !visit.isCurrentItem {
                    Button(action: {
                        self.showDeleteAlert = true
                    }) {
                        Text("Delete visit")
                        Image(systemName: "trash")
                    }
                    .foregroundColor(.red)
                    .alert(isPresented: $showDeleteAlert) {
                        Alert.delete(visit: self.visit)
                    }
                }
                NavigationLink(destination: ItemSegmentsView(timelineItem: visit)) {
                    Text("Edit individual segments")
                    Image(systemName: "ellipsis")
                }
            }
        }
    }

    var title: String {
        var debug = ""
        if visit.hasBrokenNextItemEdge { debug += "↑" }
        if visit.hasBrokenPreviousItemEdge { debug += "↓" }
        return debug + visit.title
    }

    var categoryImage: Image {
        if let image = visit.place?.categoryImage { return image }
        return Image("defaultPlaceIcon24")
    }

    var categoryColor: Color {
        if let prev = visit.previousItem as? ArcPath, let dateRange = visit.dateRange, dateRange.start.isSameDayAs(dateRange.end) {
            return prev.color
        }
        if let next = visit.nextItem as? ArcPath { return next.color }
        return Color(UIColor.arcGreen)
    }

}

//struct VisitListBox_Previews: PreviewProvider {
//    static var previews: some View {
//        VisitListBox()
//    }
//}
