//
//  Favourites.swift
//  HackingWithSwift-SnowSeeker
//
//  Created by Michael Jones on 25/09/2026.
//

import SwiftUI

@Observable
class Favourites {
    private var resorts: Set<String>
    private let key =  "Favourites"
    
    init() {
        resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        
    }
}
