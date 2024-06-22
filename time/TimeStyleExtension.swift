//
//  TimeStyleExtension.swift
//  rainmeter
//
//  Created by Kynson Szetau on 12/6/2024.
//

import Foundation

extension Date.FormatStyle.TimeStyle: RawRepresentable {
    public init?(rawValue: String) {
        let timeStyleData = Data(rawValue.utf8)
        if let decodedTimeStyle = try? decoder.decode(Date.FormatStyle.TimeStyle.self, from: timeStyleData) {
            self = decodedTimeStyle

            return
        }
        
        self = .complete
    }

    public var rawValue: String {
        if let encodedDateStyle = try? encoder.encode(self) {
            return String(data: encodedDateStyle, encoding: .utf8)!
        }
        
        // Default to abbreviated
        return "{\"rawValue\":2}"
    }
}
