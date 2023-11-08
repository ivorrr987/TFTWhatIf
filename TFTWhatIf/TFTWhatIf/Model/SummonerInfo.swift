//
//  SummonerInfo.swift
//  TFTWhatIf
//
//  Created by HAN GIBAEK on 11/8/23.
//

import Foundation

struct SummonerInfo: Codable {
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case id
    }
}
