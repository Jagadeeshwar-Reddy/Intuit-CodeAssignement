//
//  ScoreAnalysisPresenter.swift
//  ExampleApp
//
//  Created by Lucky on 16/01/20.
//  Copyright © 2020 Jagadeesh. All rights reserved.
//

import Foundation
import ScorePlotter

protocol ScoreAnalysisPresentable: class {
    func showLoading()
    func hideLoading()
    
    func update(with scoreBoard: ScoreBoard)
    func update(with error: Error)
}

protocol ScoreAnalysisPresenterType {
    var view: ScoreAnalysisPresentable? { get set }
    func fetchReport()
}

final class ScoreAnalysisPresenter: ScoreAnalysisPresenterType {
    weak var view: ScoreAnalysisPresentable?
    
    func fetchReport() {
        view?.showLoading()
        let url = "http://5e205ea1e31c6e0014c60717.mockapi.io/scorecard"
        let request = URLRequest(url: URL(string: url)!)
        URLSession.shared.dataTask(with: request) { [weak self] (data, urlResponse, error) in
            
            DispatchQueue.main.async {
                self?.view?.hideLoading()
                if let data = data, error == nil {
                    //success
                    do {
                        let scoreBoard = try JSONDecoder().decode(ScoreBoard.self, from: data)
                        
                        self?.handleSuccess(scoreBoard)
                        
                    } catch (let parsingError) {
                        
                        self?.handleError(parsingError)
                    }
                    
                } else if let error = error {
                    //error
                    self?.handleError(error)
                }
            }
            
        }.resume()
    }
    
    private func handleSuccess(_ scoreBoard: ScoreBoard) {
        view?.update(with: scoreBoard)
    }
    
    private func handleError(_ error: Error) {
        view?.update(with: error)
    }
}
