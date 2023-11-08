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
    
    var body: some View {
        VStack {
            TextField(text: $inputText) {
                Text("소환사 이름을 입력하세요.")
            }
            Button {
                Task {
                    print(inputText.replacingOccurrences(of: " ", with: ""))
                    try await RiotAPIManager.shared.validateSummonerName(summonerName: inputText, apiKey: apiKey2)
                }
            } label: {
                Text("validation")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
