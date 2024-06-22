//
//  DateStyleExtension.swift
//  rainmeter
//
//  Created by Kynson Szetau on 12/6/2024.
//

import Foundation

extension Date.FormatStyle.DateStyle: RawRepresentable {
    public init?(rawValue: String) {
        let dateStyleData = Data(rawValue.utf8)
        if let decodedDateStyle = try? decoder.decode(Date.FormatStyle.DateStyle.self, from: dateStyleData) {
            self = decodedDateStyle

            return
        }
        
        self = .abbreviated
    }

    public var rawValue: String {
        if let encodedDateStyle = try? encoder.encode(self) {
            return String(data: encodedDateStyle, encoding: .utf8)!
        }
        
        // Default to abbreviated
        return "{\"rawValue\":2}"
    }
}
