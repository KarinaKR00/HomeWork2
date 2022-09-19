//
//  Models.swift
//  HomeWork2
//
//  Created by Карина on 18.09.2022.
//

import Foundation

struct Joke: Decodable {
    let joke: String
    
}

struct JokeTwo: Decodable {
    let setup: String
    let punchline: String
}

