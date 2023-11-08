//
//  SummonerInfo.swift
//  TFTWhatIf
//
//  Created by HAN GIBAEK on 11/8/23.
//

import Foundation

struct SummonerInfo: Codable {
    let accountId: String
    let profileIconId: Int
    let revisionDate: Int
    let name: String
    let id: String
    let puuid: String
    let summonerLevel: Int
    
    enum CodingKeys: String, CodingKey {
        case accountId
        case profileIconId
        case revisionDate
        case name
        case id
        case puuid
        case summonerLevel
    }
}
