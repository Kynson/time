//
//  HorizontalAlignmentExtension.swift
//  rainmeter
//
//  Created by Kynson Szetau on 13/6/2024.
//

import Foundation
import SwiftUI

extension HorizontalAlignment: Codable {
    private static let LEADING_REPRESENTATION = 0
    private static let CENTER_REPRESENTATION = 1
    private static let TRAILINGING_REPRESENTATION = 2
    
    
    private var intRepresentation: Int {
        switch self {
        case .leading: return HorizontalAlignment.LEADING_REPRESENTATION
        case .center: return HorizontalAlignment.CENTER_REPRESENTATION
        case .trailing: return HorizontalAlignment.TRAILINGING_REPRESENTATION
            // We don't care about other alignment type as they will never be selected. Use center as default
        default:
            return HorizontalAlignment.CENTER_REPRESENTATION
        }
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(intRepresentation)
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        switch try container.decode(Int.self) {
        case HorizontalAlignment.LEADING_REPRESENTATION: self = .leading
        case HorizontalAlignment.TRAILINGING_REPRESENTATION: self = .trailing
        default: self = .center
        }
    }
}

extension HorizontalAlignment: Hashable {
    public func hash(into hasher: inout Hasher) {
        // Hash the internal int representation is more efficient than hashing the encoded rawValue
        hasher.combine(intRepresentation)
    }
}

extension HorizontalAlignment: RawRepresentable {
    public init?(rawValue: String) {
        let horizontalAlignmentData = Data(rawValue.utf8)
        if let decodedHorizontalAlignment = try? decoder.decode(HorizontalAlignment.self, from: horizontalAlignmentData) {
            self = decodedHorizontalAlignment

            return
        }
        
        self = .center
    }

    public var rawValue: String {
        if let encodedDateStyle = try? encoder.encode(self) {
            return String(data: encodedDateStyle, encoding: .utf8)!
        }
        
        // Default to center
        return String(HorizontalAlignment.CENTER_REPRESENTATION)
    }
}
