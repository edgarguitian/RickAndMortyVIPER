//
//  EpisodesListView.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation
import UIKit

class EpisodesListView: UIViewController {
    private let presenter: EpisodesListPresentable
    
    var episodesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(EpisodeCellView.self, forCellReuseIdentifier: "EpisodeCellView")
        return tableView
    }()
    
    init(presenter: EpisodesListPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        presenter.onViewAppear()
        
        self.navigationItem.title = "Episodes"

    }
    
    private func setupTableView() {
        view.addSubview(episodesTableView)
        
        NSLayoutConstraint.activate([
            episodesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            episodesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            episodesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            episodesTableView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        episodesTableView.dataSource = self
        episodesTableView.delegate = self
    }
}

extension EpisodesListView: EpisodesListUI {
    func update(episodes: [EpisodeCellViewModel]) {
        print("Datos recibidos \(episodesTableView)")
        DispatchQueue.main.async {
            self.episodesTableView.reloadData()
        }
    }
}

extension EpisodesListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.episodesModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCellView", for: indexPath) as! EpisodeCellView
        let model = presenter.episodesModels[indexPath.row]
        
        cell.configure(model: model)
        return cell
    }
}

extension EpisodesListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.onTapCell(atIndex: indexPath.row)
    }
}

