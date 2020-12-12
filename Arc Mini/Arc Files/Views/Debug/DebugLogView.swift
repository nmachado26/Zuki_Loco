//
//  DebugLogView.swift
//  Arc Mini
//
//  Created by Matt Greenfield on 9/4/20.
//  Copyright © 2020 Matt Greenfield. All rights reserved.
//

import SwiftUI

struct DebugLogView: View {

    var logURL: URL
    
    @State var fontSize: CGFloat = 8
    @EnvironmentObject var debugLogger: DebugLogger
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var canDelete: Bool {
        return logURL.lastPathComponent != DebugLogger.highlander.sessionLogFileURL.lastPathComponent
    }

    var body: some View {
        GeometryReader { metrics in
            ScrollView {
                Text(self.logText).font(.system(size: self.fontSize, weight: .regular, design: .monospaced))
                    .frame(width: metrics.size.width, alignment: .leading)
            }
            .navigationBarTitle(LocalizedStringKey((self.logURL.lastPathComponent as NSString).deletingPathExtension), displayMode: .inline)
            .navigationBarItems(trailing: HStack(spacing: 0) {
                self.fontSizeButton
                if self.canDelete {
                    self.deleteButton
                }
            })
        }
    }

    var fontSizeButton: some View {
        Button(action: {
            if self.fontSize < 12 {
                self.fontSize += 1
            } else {
                self.fontSize = 8
            }
        }) {
            Image(systemName: "textformat.size")
        }
        .frame(width: 44, height: 44)
    }

    var deleteButton: some View {
        Button(action: {
            do {
                try self.debugLogger.delete(self.logURL)
                self.presentationMode.wrappedValue.dismiss()
            } catch {
                print("Couldn't delete the log file.")
            }
        }) {
            Image(systemName: "trash")
        }
        .frame(width: 44, height: 44)
    }

    var logText: String {
        if let logString = try? String(contentsOf: logURL), !logString.isEmpty {
            return logString
        }
        return "Empty."
    }
}

//struct DebugLogView_Previews: PreviewProvider {
//    static var previews: some View {
//        DebugLogView()
//    }
//}
