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
    
    enum CodingKeys: String, CodingKey {
        case puuid, leagueId, summonerId, summonerName, queueType, ratedTier, ratedRating, tier, rank, leaguePoints, wins, losses
    }
}
