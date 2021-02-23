//
//  ContentView.swift
//  jiografia
//
//  Created by Cédric Bahirwe on 23/02/2021.
//

import SwiftUI

struct ContentView: View {
    @State var countries = DataLoader().countries
    var body: some View {
        NavigationView {
            List(countries, id: \.code) { country in
                Text(country.name)
            }
            .navigationTitle("\(countries.count) Countries")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
