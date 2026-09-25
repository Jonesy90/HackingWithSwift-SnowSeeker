//
//  ContentView.swift
//  HackingWithSwift-SnowSeeker
//
//  Created by Michael Jones on 23/09/2026.
//

import SwiftUI

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var searchResort = String()
    @State private var favourites = Favourites()
    
    var filteredResorts: [Resort] {
        if searchResort.isEmpty {
            resorts
        } else {
            resorts.filter { $0.name.localizedStandardContains(searchResort) }
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List(filteredResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(.rect(cornerRadius: 5))
                            .overlay (
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        
                        if favourites.contains(resort) {
                            Spacer()
                            
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favourite resort.")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchResort, prompt: "Search for a resort")
        } detail: {
            WelcomeView()
        }
        .environment(favourites)
    }
}

#Preview {
    ContentView()
}
