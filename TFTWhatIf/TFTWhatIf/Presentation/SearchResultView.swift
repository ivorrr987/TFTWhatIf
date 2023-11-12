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
    @State var result = "재능충 66%"
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("\(summonerName)의 판별 결과는")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(8)
            Text(result)
                .font(.title2)
                .foregroundColor(.green)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
                .padding()
            
            VStack(alignment: .center, spacing: 16) {
                Text("소환사 이름: \(summonerName)")
                
                Text("티어: \(String(describing: summonerInfo?[.tier]))")
                
                Text("랭크: \(String(describing: summonerInfo?[.rank]))")
                
                Text("승률: \(String(format: "%0.2f", summonerInfo?[.winRate] as! CVarArg))")
                
                Text("같은 티어 전체 승률: \(String(format: "%0.2f",  leagueInfo?[.totalWinRate] as! CVarArg))")
            }
            .padding(30)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray, lineWidth: 2)
            }
            
            Spacer()
            
            Button {
                takeScreenshotAndShare()
            } label: {
                Image(systemName: "square.and.arrow.up.circle")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 40)
        }
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
                    self.screenshot = croppedScreenshot
                    print("\(String(describing: self.screenshot))")
                    self.isSharing = true
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

struct ActivityView: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
