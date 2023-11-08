//
//  ContentView.swift
//  TFTWhatIf
//
//  Created by HAN GIBAEK on 11/8/23.
//

import SwiftUI

struct ContentView: View {
    let apiKey1 = Bundle.main.riotAPIKey1
    let apiKey2 = Bundle.main.riotAPIKey2
    
    @State var inputText: String = ""
    @State var isValid: Bool = false
    @State var summonerId: String?
    @State var tier: String = "아직 입력되지 않았습니다."
    @State var rank: String = "아직 입력되지 않았습니다."
    @State var wins: Int?
    @State var losses: Int?
    @State var summonerLeagueEntry: [SummonerLeagueEntry]?
    
    var body: some View {
        VStack {
            TextField(text: $inputText) {
                Text("소환사 이름을 입력하세요.")
            }
            .textFieldStyle(.roundedBorder)
            .padding()
            Button {
                Task {
                    do {
                        print(inputText.replacingOccurrences(of: " ", with: ""))
                        summonerId = try await RiotAPIManager.shared.getSummonerID(summonerName: inputText, apiKey: apiKey2)
                        print(summonerId ?? "id가 nil")
                        let summonerLeagueEntry  = try await RiotAPIManager.shared.getTier(summonerId: summonerId ?? "", apiKey: apiKey2)
                        tier = summonerLeagueEntry.first?.tier ?? "tier를 입력받지 못했습니다."
                        rank = summonerLeagueEntry.first?.rank ?? "rank를 입력받지 못했습니다."
                        wins = summonerLeagueEntry.first?.wins ?? 0
                        losses = summonerLeagueEntry.first?.losses ?? 0
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("validation")
                    .padding()
            }
            Text(tier)
            Text(rank)
            Text(String(describing: wins))
            Text(String(describing: losses))
        }
        .padding()
    }
    
    //    func getSummonerWinRate(
    
    
//    func printALot(text: String) {
//        for _ in 1...10 {
//            print(text)
//        }
//    }
//    
//    func printALotAsync(text: String) async {
//        for _ in 1...10 {
//            print(text)
//        }
//    }
}

#Preview {
    ContentView()
}
