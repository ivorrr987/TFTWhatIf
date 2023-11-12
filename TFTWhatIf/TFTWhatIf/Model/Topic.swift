//
//  Topic.swift
//  TFTWhatIf
//
//  Created by DongHyeok Kim on 11/13/23.
//

import Foundation
import SwiftUI

struct Topic: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let timeSpent: Int
    let done: String
    let count: Int

    static func == (lhs: Topic, rhs: Topic) -> Bool {
        return lhs.id == rhs.id
    }
}
