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

extension RiotAPIManager {
    func validateSummonerName(summonerName: String, apiKey: String) async throws -> Void {
        guard let url = URL(string: "https://kr.api.riotgames.com/tft/summoner/v1/summoners/by-name/\(summonerName)?api_key=\(apiKey)") else {
            print("-----bad URL!-----")
            throw RiotAPIError.invalidSummonerName
        }
        var request = URLRequest(url: url)
        let (_, response) = try await URLSession.shared.data(for: request)
        
        print(response)
    }
}


