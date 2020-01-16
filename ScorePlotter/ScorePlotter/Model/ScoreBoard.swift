//
//  ScoreBoard.swift
//  ScorePlotter
//
//  Created by Lucky on 16/01/20.
//  Copyright © 2020 Jagadeesh. All rights reserved.
//

import Foundation

// MARK: - ScoreBoard
public struct ScoreBoard: Codable {
    let userScore: Int
    let report: Report

    enum CodingKeys: String, CodingKey {
        case userScore = "user_score"
        case report = "report_stds"
    }
}

// MARK: - Stats
public struct Report: Codable {
    let min, max: Int
    let scoreStats: [ScoreStat]

    enum CodingKeys: String, CodingKey {
        case min, max
        case scoreStats = "score_stats"
    }
}

// MARK: - ScoreStat
public struct ScoreStat: Codable {
    let min, max, percent: Int
    let colorCode: String
}
