//
//  ContentView.swift
//  HackingWithSwift-SnowSeeker
//
//  Created by Michael Jones on 23/09/2026.
//

import SwiftUI

enum SortType {
    case `default`, alphabetical, county
}

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var searchResort = String()
    @State private var favourites = Favourites()
    
    @State private var sortType = SortType.default
    @State private var isShowingSort = false
    
    var filteredResorts: [Resort] {
        if searchResort.isEmpty {
            resorts
        } else {
            resorts.filter { $0.name.localizedStandardContains(searchResort) }
        }
    }
    
    var sortedResults: [Resort] {
        switch sortType {
        case .default:
            filteredResorts
        case .alphabetical:
            filteredResorts.sorted { $0.name < $1.name }
        case .county:
            filteredResorts.sorted { $0.country < $1.country }
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List(sortedResults) { resort in
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
            .toolbar {
                Button("Change Sort Order", systemImage: "arrow.up.arrow.down") {
                    isShowingSort = true
                }
            }
            .confirmationDialog("Sort Order", isPresented: $isShowingSort) {
                Button("Default") { sortType = .default }
                Button("Alphabetical") { sortType = .alphabetical }
                Button("Country") { sortType = .county }
            }
        } detail: {
            WelcomeView()
        }
        .environment(favourites)

    }
}

#Preview {
    ContentView()
}
