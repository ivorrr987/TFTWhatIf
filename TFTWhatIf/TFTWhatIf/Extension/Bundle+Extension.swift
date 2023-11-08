//
//  Bundle+Extension.swift
//  TFTWhatIf
//
//  Created by HAN GIBAEK on 11/8/23.
//

import Foundation

extension Bundle {
    
    var riotAPIKey1: String {
        guard let file = self.path(forResource: "Secret", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["RiotAPIKey1"] as? String else {
            print("Riot API Key1을 가져오는데 실패했습니다.")
            return ""
        }
        return key
    }
    
    var riotAPIKey2: String {
        guard let file = self.path(forResource: "Secret", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["RiotAPIKey2"] as? String else {
            print("Riot API Key2를 가져오는데 실패했습니다.")
            return ""
        }
        return key
    }
}
