//
//  ContentView.swift
//  rainmeter
//
//  Created by Kynson Szetau on 6/6/2024.
//

import SwiftUI
import Combine

@Observable class DateInformation {
//    // Preferences are not read outside this class, no need to observe
    @ObservationIgnored @ObservedObject var preferences = Preferences()
    
    var now = Date()

    var dayOfWeek: String {
        self.now
            .formatted(
                Date.FormatStyle().weekday(.wide)
            )
            .uppercased()
    }
    var date: String {
        self.now
            .formatted(date: preferences.dateFormat, time: .omitted)
            .uppercased()
    }
    var time: String {
        self.now
            .formatted(date: .omitted, time: preferences.timeFormat)
    }
}

struct ContentView: View {
    @State private var currentDateInfomation: DateInformation?

    @ObservedObject private var preferences = Preferences()

    let timer = Timer.publish(every: 0.5, on: .current, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            VStack {
                VStack(alignment: preferences.textAlignment, spacing: 0) {
                    Text(currentDateInfomation?.dayOfWeek ?? "")
                        .font(Font.custom(preferences.dayOfWeekFontFamily, size: preferences.dayOfWeekFontSize))
                        .tracking(preferences.dayOfWeekLetterSpacing)
                        .foregroundStyle(preferences.dayOfWeekFontColor)
                    Text(currentDateInfomation?.date ?? "")
                        .font(Font.custom(preferences.dateFontFamily, size: preferences.dateFontSize))
                        .tracking(preferences.dateLetterSpacing)
                        .foregroundStyle(preferences.dateFontColor)
                        .padding(.top, preferences.dateTopPadding)
                    Text(currentDateInfomation?.time ?? "")
                        .font(Font.custom(preferences.timeFontFamily, size: preferences.timeFontSize))
                        .tracking(preferences.timeLetterSpacing)
                        .foregroundStyle(preferences.timeFontColor)
                        .padding(.top, preferences.timeTopPadding)
                }
                .position(x: preferences.xPosition, y: preferences.yPosition)
                // Push the view to the top
                Spacer()
            }
            // Push the view to the left
            Spacer()
        }
        .task {
            // Defer the initialization before the view appears
            // As @State property always instantiates its default value when SwiftUI instantiates the view
            // Reference: https://developer.apple.com/documentation/swiftui/state#Store-observable-objects
            currentDateInfomation = DateInformation()
        }
        .onReceive(timer, perform: { now in
            currentDateInfomation?.now = now
        })
    }
}

#Preview {
    ContentView()
}
