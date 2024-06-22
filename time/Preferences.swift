//
//  Preferences.swift
//  rainmeter
//
//  Created by Kynson Szetau on 11/6/2024.
//

import Combine
import SwiftUI

// Global encoder and decorder used by extensions to encode and decode data store in App Storage
let encoder = JSONEncoder()
let decoder = JSONDecoder()

class Preferences: ObservableObject {
    @AppStorage("text-alignment") var textAlignment = HorizontalAlignment.center
    @AppStorage("x-position") var xPosition = 20.0
    @AppStorage("y-position") var yPosition = 20.0
    
    @AppStorage("day-of-week-font-family") var dayOfWeekFontFamily = "Futura-Medium"
    @AppStorage("day-of-week-font-size") var dayOfWeekFontSize = 36.0
    @AppStorage("day-of-week-font-color") var dayOfWeekFontColor = Color.black
    @AppStorage("day-of-week-letter-spacing") var dayOfWeekLetterSpacing = 30.0
    
    // "" Indicates system default font
    @AppStorage("date-font-family") var dateFontFamily: String = ""
    @AppStorage("date-font-size") var dateFontSize = 16.0
    @AppStorage("date-font-color") var dateFontColor = Color.black
    // 0.0 means system default
    @AppStorage("date-letter-spacing") var dateLetterSpacing = 0.0
    @AppStorage("date-format") var dateFormat = Date.FormatStyle.DateStyle.abbreviated
    @AppStorage("date-top-padding") var dateTopPadding = 0.0
    
    // "" Indicates system default font
    @AppStorage("time-font-family") var timeFontFamily: String = ""
    @AppStorage("time-font-size") var timeFontSize = 16.0
    @AppStorage("time-font-color") var timeFontColor = Color.black
    // 0.0 means system default
    @AppStorage("time-letter-spacing") var timeLetterSpacing = 0.0
    @AppStorage("time-format") var timeFormat = Date.FormatStyle.TimeStyle.complete
    @AppStorage("time-top-padding") var timeTopPadding = 0.0
}
