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

    @State var isSharing = false
    @State var screenshot: UIImage? = nil
    @State var isIf = false
    @State var totalGameTime: Int = 1
    

    
    var body: some View {
        VStack {
            Spacer()
            
            Text("\(summonerName)의 판별 결과는")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(8)
            if let summonerWinRate = summonerInfo?[.winRate] as? Double, let totalWinRate = leagueInfo?[.totalWinRate] as? Double {
                if summonerWinRate >= totalWinRate {
                    Text("재능충")
                        .font(.title2)
                        .foregroundColor(.green)
                }else {
                    Text("노력충")
                        .font(.title2)
                        .foregroundColor(.red)
                }
            }
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
                .padding()
            
            VStack(alignment: .center, spacing: 16) {
                Text("소환사 이름: \(summonerName)")
                
                if let tier = summonerInfo?[.tier] as? String {
                    Text("티어: \(tier)")
                } else {
                    Text("티어: 기본값") // tier 값이 존재하지 않을 때 기본값을 사용
                }

                if let rank = summonerInfo?[.rank] as? String {
                    Text("랭크: \(rank)")
                } else {
                    Text("랭크: 기본값") // rank 값이 존재하지 않을 때 기본값을 사용
                }

                
                Text("승률: \(String(format: "%0.3f", summonerInfo?[.winRate] as! CVarArg))")
                
                Text("같은 티어 전체 승률: \(String(format: "%0.3f",  leagueInfo?[.totalWinRate] as! CVarArg))")
                
                if let winRate = summonerInfo?[.winRate] as? Double, let wins = summonerInfo?[.wins] as? Int, let losses = summonerInfo?[.losses] as? Int {
                    let totalGames = wins + losses
                    let gameTime = 30 + 10 * winRate
                    let totalGameTimes = totalGames * Int(gameTime)
                    


                    Text("전체 게임 시간: \(((totalGames) * Int(gameTime)) / 60)시간")
                    Text("전체 게임 수: \(totalGames)")
                    Text("한 게임 평균 시간: \(gameTime)")
                } else {
                    // 승률, 승리 및 패배 횟수를 가져오는 데 실패한 경우의 처리를 수행할 수 있습니다.
                }

            }
            .padding(30)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray, lineWidth: 2)
            }
            
//            Button {
//                isIf.toggle()
//            } label: {
//                VStack {
//                    
//                    Text("만약 롤체를 안 했더라면...")
//                        .padding()
//                    
//                }
//                .background {
//                    RoundedRectangle(cornerRadius: 6)
//                        .stroke(Color.gray, lineWidth: 2)
//                }
//                
//            }
//            .buttonStyle(.borderless)
//            .padding(.top, 30)
            
            NavigationLink {
                WhatIFView(totalGameTime: $totalGameTime)
            } label: {
                VStack {
                    
                    Text("만약 롤체를 안 했더라면...")
                        .padding()
                    
                }
                .background {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.gray, lineWidth: 2)
                }
            }
            .padding(.top, 30)

            Spacer()
        }
        .onAppear {
            if let winRate = summonerInfo?[.winRate] as? Double, let wins = summonerInfo?[.wins] as? Int, let losses = summonerInfo?[.losses] as? Int {
                let totalGames = wins + losses
                let gameTime = 30 + 10 * winRate
                totalGameTime = totalGames * Int(gameTime) / 60
            }
        }
        .toolbar(content: {
            Button {
                takeScreenshotAndShare()
            } label: {
                Image(systemName: "square.and.arrow.up")
//                    .resizable()
//                    .frame(width: 40, height: 40)
//                    .foregroundColor(.gray)
            }

//            .padding(.bottom, 40)
        })
//        .fullScreenCover(isPresented: $isIf) {
//            WhatIFView(totalGameTime: $totalGameTime)
//        }
        .sheet(isPresented: $isSharing) {
            ActivityView(activityItems: [screenshot])

        }
    }
    
}

extension SearchResultView {
    private func takeScreenshot(of view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        view.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    private func takeScreenshotAndShare() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.first else { return }
            if let screenshot = takeScreenshot(of: window) {
                if let croppedScreenshot = cropImage(screenshot, topTrim: 0.23, bottomTrim: 0.25) {
                    let activityViewController = UIActivityViewController(activityItems: [croppedScreenshot], applicationActivities: nil)
                    window.rootViewController?.present(activityViewController, animated: true)
                }
            }
        }
    }
    
    private func cropImage(_ image: UIImage, topTrim: CGFloat, bottomTrim: CGFloat) -> UIImage? {
        let totalTrimAmount = topTrim + bottomTrim
        guard totalTrimAmount < 1 else { return nil }
        
        let size = image.size
        let rect = CGRect(
            x: 0,
            y: size.height * topTrim,
            width: size.width,
            height: size.height * (1 - totalTrimAmount)
        )
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, image.scale)
        image.draw(at: CGPoint(x: -rect.origin.x, y: -rect.origin.y))
        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return croppedImage
    }
    
}

//#Preview {
//    SearchResultView(.constant(<#T##value: String##String#>))
//}

