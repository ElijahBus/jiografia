//
//  CountriesHelper.swift
//  jiografia
//
//  Created by Cédric Bahirwe on 23/02/2021.
//

import Foundation

class DataLoader {
    var countries = [Country]()
    
    init() {
        load()
        sort()
    }
    
    func load() {
        
        if let fileLocationOne = Bundle.main.url(forResource: "CountryFlags", withExtension: "json") {
            
            do {
                let data = try Data(contentsOf: fileLocationOne)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([Country].self, from: data)
                
                countries = dataFromJson
            } catch {
                print(error)
            }
        }
    }
    
    func sort() {
        countries.sort(by: { $0.name < $1.name})
    }
}
