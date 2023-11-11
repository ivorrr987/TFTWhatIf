//
//  SearchResultView.swift
//  TFTWhatIf
//
//  Created by HAN GIBAEK on 11/9/23.
//

import SwiftUI

struct SearchResultView: View {
    @Binding var summonerName: String
    @Binding var summonerInfo: [SummonerInfoKey: Any]?
    @Binding var leagueInfo: [LeagueInfoKey: Any]?
    
    
    var body: some View {
        VStack {
            Text("소환사 이름: \(summonerName)")
            Text("티어: \(String(describing: summonerInfo?[.tier]))")
            Text("랭크: \(String(describing: summonerInfo?[.rank]))")
            Text("승률: \(String(format: "%0.2f", summonerInfo?[.winRate] as! CVarArg))")
            Text("같은 티어 전체 승률: \(String(format: "%0.2f",  leagueInfo?[.totalWinRate] as! CVarArg))")
        }
    }
}

//#Preview {
//    SearchResultView(.constant(<#T##value: String##String#>))
//}
