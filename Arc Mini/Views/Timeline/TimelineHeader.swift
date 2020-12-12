//
//  TimelineHeader.swift
//  Arc Mini
//
//  Created by Matt Greenfield on 10/3/20.
//  Copyright © 2020 Matt Greenfield. All rights reserved.
//

import SwiftUI

struct TimelineHeader: View {

    @EnvironmentObject var timelineState: TimelineState

    @State var showingMenu = false
    @State var showingModal = false
    @State var modalView: ModalView = .logs
    @State var optionsMenu: OptionsMenu = .main
    @State var exportURL: URL?

    enum ModalView { case logs, system, recording, export }
    enum OptionsMenu { case main, export }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text(dailyTitle)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(Color("brandTertiaryDark"))
                Spacer()
                self.previousButton
                self.nextButton
                Rectangle().fill(Color("grey")).frame(width: 1, height: 24)
                Button {
                    self.optionsMenu = .main
                    self.showingMenu = true
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(Color("brandSecondary80"))
                        .frame(width: 56, height: 64)
                }
            }
            .padding([.leading], 20)
            .padding([.trailing], 4)
            .frame(height: 64)
            Rectangle().fill(Color("brandSecondary10")).frame(height: 0.5).padding([.leading, .trailing], 20)
        }
        .background(Color("background"))
        .sheet(isPresented: $showingModal) {
            if self.modalView == .logs {
                DebugLogsView().environmentObject(DebugLogger.highlander)
            } else if self.modalView == .system {
                SystemDebugView()
            } else if self.modalView == .recording {
                RecordingDebugView()
            } else if self.modalView == .export {
                ShareSheet(activityItems: [self.exportURL!])
            }
        }
        .actionSheet(isPresented: $showingMenu) {
            if self.optionsMenu == .main {
                return ActionSheet(title: Text("Options Menu"), buttons: [
                    .default(Text("Export")) {
                        delay(0.1) {
                            self.optionsMenu = .export
                            self.showingMenu = true
                        }
                    },
                    .default(Text("Debug Logs")) {
                        self.modalView = .logs
                        self.showingModal = true
                    },
                    .default(Text("System Debug Info")) {
                        self.modalView = .system
                        self.showingModal = true
                    },
                    .default(Text("Recording Debug Info")) {
                        self.modalView = .recording
                        self.showingModal = true
                    },
                    .destructive(Text("Close"))
                ])
            } else {
                return ActionSheet(title: Text("Export Menu"), buttons: [
                    .default(Text("Export timeline as GPX")) {
                        self.exportToGPX()
                    },
                    .default(Text("Export timeline as JSON")) {
                        self.exportToJSON()
                    },
                    .destructive(Text("Close"))
                ])
            }
        }
    }

    var dailyTitle: String {
        guard let day = timelineState.visibleDateRange?.start else { return "Eh?" }
        let formatter = TimelineState.dateFormatter
        if day.isToday || day.isYesterday {
            formatter.dateFormat = nil
            formatter.doesRelativeDateFormatting = true
            formatter.dateStyle = .long
            formatter.timeStyle = .none
        } else {
            formatter.setLocalizedDateFormatFromTemplate("EEE d MMM yyyy")
        }
        return formatter.string(from: day)
    }

    var previousButton: some View {
        Button(action: {
            self.timelineState.gotoPrevious()
        }) {
            Image(systemName: "chevron.left").foregroundColor(Color("brandSecondary80"))
        }
        .frame(width: 56, height: 64)
    }

    var nextButton: some View {
        Button(action: {
            self.timelineState.gotoNext()
        }) {
            Image(systemName: "chevron.right").foregroundColor(Color("brandSecondary80"))
        }
        .frame(width: 56, height: 64)
    }

    func exportToJSON() {
        guard let tempURL = timelineState.visibleTimelineSegment?.exportToJSON(filenameType: .day) else { return }
        self.exportURL = tempURL
        self.modalView = .export
        self.showingModal = true
    }

    func exportToGPX() {
        guard let segment = timelineState.visibleTimelineSegment else { return }
        guard let tempURL = GPX(segment: segment).exportToFile(filenameType: .day) else { return }
        self.exportURL = tempURL
        self.modalView = .export
        self.showingModal = true
    }

}

struct TimelineHeader_Previews: PreviewProvider {
    static var previews: some View {
        TimelineHeader()
    }
}
