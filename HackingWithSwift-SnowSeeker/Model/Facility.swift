//
//  Facility.swift
//  HackingWithSwift-SnowSeeker
//
//  Created by Michael Jones on 25/09/2026.
//

import SwiftUI

struct Facility: Identifiable {
    var id = UUID()
    var name: String
    
    private let icons = [
        "Accommodation": "house",
        "Beginners": "1.circle",
        "Cross-country": "map",
        "Eco-friendly": "leaf.arrow.circlepath",
        "Family": "person.3"
    ]
    
    private let descriptions = [
        "Accommodation": "This resort has popular onsite accommodation.",
        "Beginners": "This resort has a lot of ski schools.",
        "Cross-country": "This resort has many cross country ski routes.",
        "Eco-friendly": "This resort has won an award enviromental friendliness.",
        "Family": "This resort is popular with families."
    ]
    
    var icon: some View {
        if let iconName = icons[name] {
            Image(systemName: iconName)
                .accessibilityLabel(name)
                .foregroundStyle(.secondary)
        } else {
            fatalError("Unknown facility type: \(name)")
        }
    }
    
    var description: String {
        if let message = descriptions[name] {
            message
        } else {
            fatalError("Unknown facility type: \(name)")
        }
    }
    
    init(name: String) {
        self.id = UUID()
        self.name = name
    }
}
