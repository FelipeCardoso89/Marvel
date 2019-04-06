//
//  MarvelAPI.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 05/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation

class MarvelAPI {
    
    static let shared = MarvelAPI(
        baseURL: URL(string: "https://gateway.marvel.com:443")!,
        apiKey: "1951bc8fc24c16592930f688c6df1581"
    )

    lazy var characterService: MVLCharacterService = {
        return MVLCharacterService(baseURL: baseURL, apiKey: apiKey)
    }()
    
    private let baseURL: URL
    private let apiKey: String
    
    init(baseURL: URL, apiKey: String) {
        self.baseURL = baseURL
        self.apiKey = apiKey
    }
    
    func
    
}
