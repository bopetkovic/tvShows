//
//  EpisodeDetails.swift
//  TvShows
//
//  Created by Bojan Petkovic on 30/09/2018.
//

import Foundation

struct EpisodeDetails: Decodable {
    let showId: String
    let id: String
    let title: String
    let description: String
    let episodeNumber: String
    let season: String
    let imageUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case showId
        case id = "_id"
        case title
        case description
        case episodeNumber
        case season
        case imageUrl
    }
}
