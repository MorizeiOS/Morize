//
//  ResultsViewModel.swift
//  Morize (iOS)
//
//  Created by Jinhee on 2021/12/30.
//

import Foundation

struct ResultsViewModel {
    let selectionCount: (correct: Int, incorrect: Int)
    let gameStartTime: Date
    let gameEndTime: Date
    
    var finalPercentText: String {
        "\(score) %"
    }
    
    // 등급
    var letterGradeText: String {
        switch score {
        case 90...100: return "A"
        case 80..<90: return "B"
        case 70..<80: return "C"
        case 60..<70: return "D"
        case 0..<60: return "F"
        default: return "?"
        }
    }
    
    // 맞은 개수
    var correctSelectionText: String {
        "\(selectionCount.correct) ✅"
    }
    
    // 틀린 개수
    var incorrectSelectionText: String {
        "\(selectionCount.incorrect) ❌"
    }
    
    // 걸린 시간 
    var totalGameTimeText: String {
        "\(Int(gameEndTime.timeIntervalSince(gameStartTime))) seconds"
    }
    
    private var score: Int {
        selectionCount.correct * 100 / (selectionCount.correct + selectionCount.incorrect)
    }
}
