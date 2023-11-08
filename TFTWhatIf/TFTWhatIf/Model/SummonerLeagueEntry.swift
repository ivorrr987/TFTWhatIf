//
//  SummonerInfo.swift
//  TFTWhatIf
//
//  Created by HAN GIBAEK on 11/8/23.
//

import Foundation

struct SummonerLeagueEntry: Codable {
    
    let puuid: String
    let leagueId: String
    let summonerId: String
    let summonerName: String
    let queueType: String
    let ratedTier: String = ""
    let ratedRating: Int = 0
    let tier: String
    let rank: String
    let leaguePoints: Int
    let wins: Int
    let losses: Int
    let hotStreak: Bool
    let veteran: Bool
    let freshBlood: Bool
    let inactive: Bool
    let miniSeries: MiniSeries = MiniSeries()
    
    enum CodingKeys: String, CodingKey {
        case puuid, leagueId, summonerId, summonerName, queueType, ratedTier, ratedRating, tier, rank, leaguePoints, wins, losses, hotStreak, veteran, freshBlood, inactive, miniSeries
    }
}

struct MiniSeries: Codable {
    let losses: Int = 0
    let progress: String = ""
    let target: Int = 0
    let wins: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case losses, progress, target, wins
    }
}
