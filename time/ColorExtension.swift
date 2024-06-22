//
//  Preferences.swift
//  time
//
//  Created by Kynson Szetau on 8/6/2024.
//

import SwiftUI

extension Color: RawRepresentable {
    public init?(rawValue: String) {
        let colorData = Data(rawValue.utf8)
        if let decodedColorComponents = try? decoder.decode([Double].self, from: colorData) {
            self = Color(red: decodedColorComponents[0], green: decodedColorComponents[1], blue: decodedColorComponents[2], opacity: decodedColorComponents[3])

            return
        }
        
        self = .black
    }

    public var rawValue: String {
        let resolvedColor = self.resolve(in: EnvironmentValues())
        let resolvedColorComponents = [resolvedColor.red, resolvedColor.green, resolvedColor.blue, resolvedColor.opacity].map { component in
            Double(component)
        }
        if let encodedColor = try? encoder.encode(resolvedColorComponents) {
            return String(data: encodedColor, encoding: .utf8)!
        }
        
        // Value of black
        return "[0.0,0.0,0.0,1.0]"
    }
}
