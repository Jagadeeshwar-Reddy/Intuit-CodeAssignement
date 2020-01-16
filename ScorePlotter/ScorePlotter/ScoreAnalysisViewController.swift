//
//  ScoreAnalysisViewController.swift
//  ScorePlotter
//
//  Created by Lucky on 16/01/20.
//  Copyright © 2020 Jagadeesh. All rights reserved.
//

import UIKit

open class ScoreAnalysisViewController: UIViewController {
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.frame = view.bounds
        return stackView
    }()
    
    private lazy var scoreView: ScoreArcView = {
        let view = ScoreArcView()
        view.fillColor = UIColor.systemYellow
        return view
    }()
    
    private lazy var scoreStatsTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        let scoreCellNib = UINib(nibName: "ScoreRangesCell", bundle: Bundle(for: ScoreRangesCell.self))
        tableView.register(scoreCellNib, forCellReuseIdentifier: "ScoreRangesCell")
        tableView.estimatedRowHeight = 62.0
        return tableView
    }()
    
    public var scoreBoard: ScoreBoard? {
        didSet {
            scoreView.score = scoreBoard?.userScore ?? 0
            scoreView.layoutSubviews()
            scoreStatsTableView.reloadData()
        }
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scoreView.layoutSubviews()
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(containerStackView)
        
        containerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        [scoreView, scoreStatsTableView].forEach { containerStackView.addArrangedSubview($0) }
    }
    
    override open func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { [weak self] context in
            if UIDevice.current.orientation.isLandscape {
                self?.containerStackView.axis = .horizontal
            } else {
                self?.containerStackView.axis = .vertical
            }
        })
    }
}

extension ScoreAnalysisViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreRangesCell", for: indexPath) as! ScoreRangesCell
        guard let scoreBoard = scoreBoard else {
            fatalError("ScoreStats should not be nil")
        }
        cell.configue(with: scoreBoard.report.scoreStats[indexPath.row], userScore: scoreBoard.userScore)
        cell.selectionStyle = .none
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreBoard?.report.scoreStats.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let _ = scoreBoard else { return nil }
        
        let hview = UIView()
        hview.bounds = CGRect(x: 0.0, y: 0.0, width: tableView.bounds.width, height: 44.0)
        hview.backgroundColor = UIColor.white
        let label = UILabel()
        label.text = "Where You Stand"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22, weight: .light)
        hview.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: hview.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: hview.leadingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: hview.bottomAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: hview.trailingAnchor).isActive = true

        return hview
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let _ = scoreBoard else { return 0.0 }
        return 44.0
    }
}

extension ScoreAnalysisViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62.0
    }
}
