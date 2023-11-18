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

enum SummonerInfoKey {
    case tier
    case rank
    case wins
    case losses
    case winRate
}

enum LeagueInfoKey {
    case totalWins
    case totalLosses
    case totalWinRate
}


final class RiotAPIManager {
    static let shared = RiotAPIManager()
    let sessionID = UUID().uuidString
    var totalWinRate: Double = 50.0
    
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

// MARK: - 유저 전적
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

// MARK: - 티어 별 전적
extension RiotAPIManager {
    
    func getLeagueStats(tier: String, rank: String, apiKey: String) async throws -> [TFTLeagueStats] {
        let urlQuery = "https://kr.api.riotgames.com/tft/league/v1/entries/\(tier)/\(rank)?queue=RANKED_TFT&page=1&api_key=\(apiKey)"
        
        guard let url = URL(string: urlQuery) else {
            print("-----bad URL!-----")
            throw RiotAPIError.badURL
        }
        
        let request = URLRequest(url: url)
        let (responseData, response) = try await URLSession.shared.data(for: request)
        print("getLeagueStats's response: \(response)")
        
        let result = try JSONDecoder().decode([TFTLeagueStats].self, from: responseData)
        return result
    }
    
    func getHighLeagueStats(tier: String, apiKey: String) async throws ->
    LeagueListDTO {
        let urlQuery = "https://kr.api.riotgames.com/tft/league/v1/\(tier.lowercased())?queue=RANKED_TFT&api_key=\(apiKey)"
        

        guard let url = URL(string: urlQuery) else {
            print("-----bad URL!-----")
            throw RiotAPIError.badURL
        }

        let request = URLRequest(url: url)
        let (responseData, response) = try await URLSession.shared.data(for: request)
        print("getMasterTierSummoners's response: \(response)")

        let result = try JSONDecoder().decode(LeagueListDTO.self, from: responseData)
        return result
    }
}


// MARK: - 각종 함수
extension RiotAPIManager {
    
    func getSummonerInfo(summonerLeagueEntry: [SummonerLeagueEntry]?) -> [SummonerInfoKey: Any]{
        
        let tier = summonerLeagueEntry?.first?.tier ?? "tier를 입력받지 못했습니다."
        let rank = summonerLeagueEntry?.first?.rank ?? "rank를 입력받지 못했습니다."
        let wins = summonerLeagueEntry?.first?.wins ?? 0
        let losses = summonerLeagueEntry?.first?.losses ?? 1
        
        let result: [SummonerInfoKey: Any] = [
            .tier: tier,
            .rank: rank,
            .wins: wins,
            .losses: losses,
            .winRate: Double(wins) / Double(wins + losses)
        ]
        
        return result
    }
    
    func getLeagueInfo(tftLeagueStats: [TFTLeagueStats]?) -> [LeagueInfoKey: Any]{
        
        let totalWins = tftLeagueStats?.first?.wins ?? 0
        let totalLosses = tftLeagueStats?.first?.losses ?? 1
        
        let result: [LeagueInfoKey: Any] = [
            .totalWins: totalWins,
            .totalLosses: totalLosses,
            .totalWinRate: getTotalWinRate(tftLeagueStats: tftLeagueStats)
        ]
        
        return result
    }
    
    func getTotalWinRate(tftLeagueStats: [TFTLeagueStats]?) -> Double {
        
        let totalWins: Double = Double(tftLeagueStats?.reduce(0, { $0 + $1.wins }) ?? 0)
        let totalLosses: Double = Double(tftLeagueStats?.reduce(0, { $0 + $1.losses }) ?? 1)
        
        return totalWins / (totalWins + totalLosses)
    }
    
    func getHighLeagueInfo(leagueListDTO: LeagueListDTO?) -> [LeagueInfoKey: Any] {
        let totalWins = leagueListDTO?.entries.first?.wins ?? 0
        let totalLosses = leagueListDTO?.entries.first?.losses ?? 1
        
        let result: [LeagueInfoKey: Any] = [
            .totalWins: totalWins,
            .totalLosses: totalLosses,
            .totalWinRate: getHighTotalWinRate(leagueListDTO: leagueListDTO)
        ]
        
        return result
    }

    func getHighTotalWinRate(leagueListDTO: LeagueListDTO?) -> Double {
        let totalWins: Double = Double(leagueListDTO?.entries.reduce(0, { $0 + $1.wins }) ?? 0)
        let totalLosses: Double = Double(leagueListDTO?.entries.reduce(0, { $0 + $1.losses }) ?? 1)
        
        return totalWins / (totalWins + totalLosses)
    }
}


