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
    
    @State var summonerName: String = ""
    @State var isValid: Bool = false
    
    @State var summonerId: String?
    
    @State var summonerInfo: [SummonerInfoKey: Any]?
    @State var leagueInfo: [LeagueInfoKey: Any]?
    
//    @State var summonerLeagueEntry: [SummonerLeagueEntry]?
//    @State var tier: String = "아직 입력되지 않았습니다."
//    @State var rank: String = "아직 입력되지 않았습니다."
//    @State var wins: Int?
//    @State var losses: Int?
//
//    @State var tftLeagueStats: [TFTLeagueStats]?
    
    @State var isSearched: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Title")
                .font(.title)
                .bold()
                .foregroundColor(.gray)
                .padding(.bottom, 16)
            
            HStack {
                TextField(text: ($summonerName)) {
                    Text("소환사 이름을 입력하세요.")
                        .foregroundColor(.gray)
                }
                .onSubmit { fetchID() }
                .foregroundColor(.gray)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                }
                
                Button(action: {
                    self.summonerName = ""
                }) {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.gray)
                }
                .padding(.leading, -40)
                .opacity(summonerName.isEmpty ? 0 : 1)
                .animation(.easeInOut, value: summonerName.isEmpty)
                searchButton()
            } // HStack
            .padding(.bottom, 16)
            
            Text("아이디 찾기 오류 !")
                .foregroundColor(.red)
                .opacity(!isValid ? 0 : 1)
                .animation(.easeInOut, value: isValid)
            
            Spacer()
        }
        .padding()
        
        NavigationLink(isActive: $isSearched) {
            SearchResultView(summonerName: $summonerName, summonerInfo: $summonerInfo, leagueInfo: $leagueInfo)
        } label: {
            
        }

        
    }
    
    func getSummonerWinRate(wins: Int, losses: Int) -> Double {
        return Double(wins) / Double(wins + losses)
    }
    
    func searchButton() -> some View {
        Button {
            fetchID()
        } label: {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background {
                    Circle()
                        .stroke(Color.gray)
                }
        }
    }
}

extension ContentView {
    private func fetchID() {
        Task {
            do {
                let summonerId = try await RiotAPIManager.shared.getSummonerID(summonerName: summonerName, apiKey: apiKey2)
                let summonerLeagueEntry  = try await RiotAPIManager.shared.getTier(summonerId: summonerId , apiKey: apiKey2)
                let tier = summonerLeagueEntry.first?.tier ?? "tier를 입력받지 못했습니다."
                let rank = summonerLeagueEntry.first?.rank ?? "rank를 입력받지 못했습니다."
                
                let tftLeagueStats = try await RiotAPIManager.shared.getLeagueStats(tier: tier, rank: rank, apiKey: apiKey2)
                
                summonerInfo = RiotAPIManager.shared.getSummonerInfo(summonerLeagueEntry: summonerLeagueEntry)
                leagueInfo = RiotAPIManager.shared.getLeagueInfo(tftLeagueStats: tftLeagueStats)
                
                isSearched.toggle()
                isValid = false
            } catch {
                print(error.localizedDescription)
                isValid.toggle()
            }
        }
    }
}

//
//#Preview {
//    ContentView()
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

