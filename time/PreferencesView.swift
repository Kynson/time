//
//  PreferencesView.swift
//  time
//
//  Created by Kynson Szetau on 7/6/2024.
//

import SwiftUI

struct NumberField: View {
    var label: String = ""
    var inRange: ClosedRange<Double> = -.infinity...(.infinity)

    @Binding var value: Double
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Stepper(value: $value, in: inRange) {
                TextField("", value: $value, format: .number)
            }
            .frame(maxWidth: 80)
        }
    }
}

struct FontPreferencesView: View {
    @Binding var family: String
    @Binding var size: Double
    @Binding var color: Color
    @Binding var letterSpacing: Double
    
    // "" is used for system default font
    private let availableFontNames = [""] + NSFontManager.shared.availableFonts
    
    var body: some View {
        Picker("Font Family", selection: $family) {
            ForEach(availableFontNames, id: \.self) { name in
                Text(name.isEmpty ? "System Default" : name)
                    .font(
                        name.isEmpty ? .system(size: 13) : .custom(name, size: 13)
                    )
            }
        }
        NumberField(label: "Font Size", value: $size)
        ColorPicker("Text Color", selection: $color)
        NumberField(label: "Letter Spacing", value: $letterSpacing)
    }
}

struct PreferencesView: View {
    @StateObject private var preferences = Preferences()
    
    private let screenWidth = NSScreen.main?.frame.width
    private let screenHeight = NSScreen.main?.frame.height
    
    var body: some View {
        ScrollView {
            Form {
                Section {
                    Picker("Text Alignment", selection: preferences.$textAlignment) {
                        Label("Leading", systemImage: "text.alignleft").tag(HorizontalAlignment.leading)
                        Label("Center", systemImage: "text.aligncenter").tag(HorizontalAlignment.center)
                        Label("Trailing", systemImage: "text.alignright").tag(HorizontalAlignment.trailing)
                    }
                    .pickerStyle(.segmented)
                    .labelStyle(.iconOnly)
                    NumberField(label: "X Position", inRange: 20...(screenWidth ?? 1024), value: preferences.$xPosition)
                    NumberField(label: "Y Position", inRange: 20...(screenHeight ?? 1024), value: preferences.$yPosition)
                } header: {
                    Text("General").font(.title3).bold()
                } footer: {
                    (Text("Current Screen Size: ") + (screenWidth != nil ? Text("\(Int(screenWidth!))x\(Int(screenHeight!))") : Text("N/A. Default to 1024x1024")))
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                    Spacer()
                }
                Section(header: Text("Day of Week").font(.title3).bold()) {
                    FontPreferencesView(family: preferences.$dayOfWeekFontFamily, size: preferences.$dayOfWeekFontSize, color: preferences.$dayOfWeekFontColor,
                                        letterSpacing: preferences.$dayOfWeekLetterSpacing)
                }
                Section(header: Text("Date").font(.title3).bold()) {
                    Section {
                        Picker("Date Format", selection: preferences.$dateFormat) {
                            Text("Numeric").tag(Date.FormatStyle.DateStyle.numeric)
                            Text("Abbreviated").tag(Date.FormatStyle.DateStyle.abbreviated)
                            Text("Long").tag(Date.FormatStyle.DateStyle.long)
                        }
                        NumberField(label: "Top Padding", inRange: 0...1000, value: preferences.$dateTopPadding)
                    }
                    Section {
                        FontPreferencesView(family: preferences.$dateFontFamily, size: preferences.$dateFontSize, color: preferences.$dateFontColor, letterSpacing: preferences.$dateLetterSpacing)
                    }
                }
                Section(header: Text("Time").font(.title3).bold()) {
                    Section {
                        Picker("Time Format", selection: preferences.$timeFormat) {
                            Text("Shorten").tag(Date.FormatStyle.TimeStyle.shortened)
                            Text("Stardard").tag(Date.FormatStyle.TimeStyle.standard)
                            Text("Complete").tag(Date.FormatStyle.TimeStyle.complete)
                        }
                        NumberField(label: "Top Padding", inRange: 0...1000, value: preferences.$timeTopPadding)
                    }
                    Section {
                        FontPreferencesView(family: preferences.$timeFontFamily, size: preferences.$timeFontSize, color: preferences.$timeFontColor, letterSpacing: preferences.$timeLetterSpacing)
                    }
                }
            }
            .textFieldStyle(.roundedBorder)
            .formStyle(.grouped)
            .scrollDisabled(true)
        }
    }
}

#Preview {
    PreferencesView()
}
