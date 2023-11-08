//
//  RiotAPIManager.swift
//  TFTWhatIf
//
//  Created by HAN GIBAEK on 11/8/23.
//

import Foundation

enum RiotAPIError: Error {
    case invalidSummonerName
    case badURL
}


final class RiotAPIManager {
    static let shared = RiotAPIManager()
    let sessionID = UUID().uuidString
    
    private init() {}
}

// MARK: - 소환사 ID
extension RiotAPIManager {
    
    func getSummonerID(summonerName: String, apiKey: String) async throws -> String {
        let urlQuery = "https://kr.api.riotgames.com/tft/summoner/v1/summoners/by-name/\(summonerName.urlEncoded)?api_key=\(apiKey)"
        
        guard let url = URL(string: urlQuery) else {
            print("-----bad URL!-----")
            throw RiotAPIError.badURL
        }
        
        let request = URLRequest(url: url)
        let (responseData, response) = try await URLSession.shared.data(for: request)
        print("getSummonerId's response: \(response)")
        
        let result = try JSONDecoder().decode(SummonerInfo.self, from: responseData)
        
        return result.id
    }
}

extension RiotAPIManager {
    
    func getTier(summonerId: String, apiKey: String) async throws -> [SummonerLeagueEntry] {
        let urlQuery = "https://kr.api.riotgames.com/tft/league/v1/entries/by-summoner/\(summonerId.urlEncoded)?api_key=\(apiKey)"
        
        guard let url = URL(string: urlQuery) else {
            print("-----bad URL!-----")
            throw RiotAPIError.badURL
        }
        
        let request = URLRequest(url: url)
        let (responseData, response) = try await URLSession.shared.data(for: request)
        print("getTier's response: \(response)")
        
        let result = try JSONDecoder().decode([SummonerLeagueEntry].self, from: responseData)
        return result
    }
}


