import Foundation

struct LeagueListDTO: Codable {
    let leagueId: String
    let entries: [LeagueItemDTO]
    let tier: String
    let name: String
    let queue: String
    
    enum CodingKeys: String, CodingKey {
        case leagueId, entries, tier, name, queue
    }
}

struct LeagueItemDTO: Codable {
    let freshBlood: Bool
    let wins: Int
    let summonerName: String
    let miniSeries: MiniSeriesDTO?
    let inactive: Bool
    let veteran: Bool
    let hotStreak: Bool
    let rank: String
    let leaguePoints: Int
    let losses: Int
    let summonerId: String
    
    enum CodingKeys: String, CodingKey {
        case freshBlood, wins, summonerName, miniSeries, inactive, veteran, hotStreak, rank, leaguePoints, losses, summonerId
    }
}

struct MiniSeriesDTO: Codable {
    let losses: Int
    let progress: String
    let target: Int
    let wins: Int
    
    enum CodingKeys: String, CodingKey {
        case losses, progress, target, wins
    }
}
