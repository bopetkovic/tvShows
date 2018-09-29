//
//  Episode.swift
//  TvShows
//
//  Created by Bojan Petkovic on 28/09/2018.
//

import Foundation

struct Episode: Decodable {
    let id: String
    let title: String
    let description: String
    let imageUrl: String
    let episodeNumber: String
    let season: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case description
        case imageUrl
        case episodeNumber
        case season
    }
}
