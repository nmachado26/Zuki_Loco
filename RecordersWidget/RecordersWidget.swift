//
//  RecordersWidget.swift
//  RecordersWidget
//
//  Created by Matt Greenfield on 28/6/20.
//  Copyright © 2020 Matt Greenfield. All rights reserved.
//

import WidgetKit
import SwiftUI
import LocoKit

struct Provider: TimelineProvider {
    public typealias Entry = SimpleEntry
    
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date())
    }
    
    public func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }
    
    public func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entries: [SimpleEntry] = [SimpleEntry(date: Date())]
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
}

struct RecordersWidgetEntryView: View {
    
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry
    
    let appGroup = AppGroup(appName: .arcMini, suiteName: "group.ArcApp", readOnly: true)
    
    var body: some View {
        HStack {
            ZStack {
                Image("ch_1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    ProgressBar(value: 0.74).frame(height: 20).padding(10)
                    //                    Text("\(0.74 * 100, specifier: "%.0f")% of weekly goals completed")
                    //                        .foregroundColor(Color.init(hex: "CECECE"))
                }.offset(x: 25, y: 90)
            }
            VStack {
                Spacer()
                Image("recycle")
                    .resizable()
                    .scaledToFit() // <=== Saves aspect ratio
                    .frame(width: 50.0, height:50)
                    .background(Circle().stroke(Color.green, lineWidth: 2).frame(width: 60, height: 60))
                Spacer()
                Image("running")
                    .resizable()
                    .scaledToFit() // <=== Saves aspect ratio
                    .frame(width: 50.0, height:50)
                    .background(Circle().stroke(Color.green, lineWidth: 2).frame(width: 60, height: 60))
                Spacer()
                Image("wateer")
                    .resizable()
                    .scaledToFit() // <=== Saves aspect ratio
                    .frame(width: 50.0, height:50)
                    .background(Circle().stroke(Color.green, lineWidth: 2).frame(width: 60, height: 60))
                Spacer()
            }
            Spacer()
            
        }
        //            Spacer()
        //            Text("Right side")
        //            Spacer(minLength: 30)
    }
    //        ZStack(alignment: .top) {
    //            VStack(alignment: .leading) {
    //                HStack {
    //                    Text("Arc Recorders").font(.system(size: 14, weight: .semibold))
    //                        .frame(height: 28)
    //                }
    //                ForEach(appGroup.sortedApps, id: \.updated) { appState in
    //                    if appState.isAlive || family == .systemSmall {
    //                        self.row(
    //                            leftText: appState.isAlive ? Text(appState.recordingState.rawValue) : Text("dead"),
    //                            rightText: Text(appState.appName.rawValue),
    //                            isActiveRecorder: appState.isAliveAndRecording, isAlive: appState.isAlive
    //                        ).frame(height: 28)
    //                    } else {
    //                        self.row(
    //                            leftText: Text("dead (") + Text(appState.updated, style: .relative) + Text(" ago)"),
    //                            rightText: Text(appState.appName.rawValue),
    //                            isActiveRecorder: appState.isAliveAndRecording, isAlive: false
    //                        ).frame(height: 28)
    //                    }
    //                }
    //                Spacer()
    //            }
    //
    //            if appGroup.currentRecorder == nil {
    //                HStack {
    //                    Spacer()
    //                    Image("warningIcon20").renderingMode(.template).foregroundColor(Color.red)
    //                }
    //            }
    //
    //            VStack {
    //                Spacer()
    //                Text(Date(), style: .relative)
    //                    .multilineTextAlignment(.center)
    //                    .font(.system(size: 8, weight: .regular))
    //                    .opacity(0.3)
    //            }
    //        }
    //.padding([.top, .leading, .trailing], family == .systemLarge ? 16 : 20)
    //.padding([.bottom], 4)
}

func row(leftText: Text, rightText: Text, isActiveRecorder: Bool = false, isAlive: Bool = false) -> some View {
    return HStack {
        leftText.font(isActiveRecorder ? Font.system(.footnote).bold() : Font.system(.footnote)).opacity(isAlive ? 0.6 : 0.4)
        Spacer()
        rightText.font(Font.system(.footnote).bold())
        //                .opacity(isAlive ? 1 : 0.4)
    }
}




@main
struct RecordersWidget: Widget {
    private let kind: String = "RecordersWidget"
    
    public var body: some WidgetConfiguration {
        StaticConfiguration<RecordersWidgetEntryView>(kind: kind, provider: Provider()) { entry in
            RecordersWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Arc Recorders")
        .description("Status of Arc recorders.")
        .supportedFamilies([.systemLarge])
    }
}


struct ProgressBar: View {
    var value: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width - 90 , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color.init(hex: "CDCDCD"))
                
                Rectangle().frame(width: min(CGFloat(self.value)*(geometry.size.width - 90), geometry.size.width - 90), height: geometry.size.height)
                    .foregroundColor(Color.init(hex: "62D7A9"))
                    .animation(.linear)
            }.cornerRadius(5.0)
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

