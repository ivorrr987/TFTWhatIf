//
//  TFTLeagueStats.swift
//  TFTWhatIf
//
//  Created by HAN GIBAEK on 11/8/23.
//

import Foundation

struct TFTLeagueStats: Codable {
    let wins: Int
    let losses: Int
    
    enum CodingKeys: String, CodingKey {
        case wins, losses
    }
}

