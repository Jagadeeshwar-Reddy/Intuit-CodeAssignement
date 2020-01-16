//
//  ViewController.swift
//  ExampleApp
//
//  Created by Lucky on 16/01/20.
//  Copyright © 2020 Jagadeesh. All rights reserved.
//

import UIKit
import ScorePlotter

final class ViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private lazy var refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshData))
    private let svc = ScoreAnalysisViewController()
    private var presenter: ScoreAnalysisPresenterType = ScoreAnalysisPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(svc)
        view.addSubview(svc.view)
        svc.view.frame = self.view.bounds
        svc.didMove(toParent: self)
        
        presenter.view = self
        presenter.fetchReport()
    }

    @objc private func refreshData() {
        presenter.fetchReport()
    }
}

extension ViewController: ScoreAnalysisPresentable {
    func showLoading() {
        svc.view.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        navigationItem.rightBarButtonItem = nil
    }
    
    func hideLoading() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        navigationItem.rightBarButtonItem = refreshButton
    }
    
    func update(with scoreBoard: ScoreBoard) {
        svc.view.isHidden = false
        svc.scoreBoard = scoreBoard
    }
    
    func update(with error: Error) {
        let alert = UIAlertController(title: "Something went wrong!", message: "Failed to fetch data. Try refreshing", preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
    }
    
}
