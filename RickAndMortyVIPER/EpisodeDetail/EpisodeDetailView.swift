//
//  EpisodeDetailView.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation
import UIKit
import Kingfisher

class EpisodeDetailView: UIViewController {
    private let presenter: EpisodeDetailPresentable
    
    
    let episodeName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    var episodeTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CharactersCell")
        return tableView
    }()
    
    func createInfoStackView(title: String, value: String) -> UIStackView {
        let titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            label.numberOfLines = 1
            label.lineBreakMode = .byTruncatingTail
            label.text = title
            return label
        }()
        
        let valueLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 18)
            label.numberOfLines = 1
            label.lineBreakMode = .byTruncatingTail
            label.text = value
            return label
        }()
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, UIView(), valueLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        
        return stackView
    }
    
    func createTitleSection(title: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = title
        return label
    }
    
    init(presenter: EpisodeDetailPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setupView()
        presenter.onViewAppear()
    }
    
    func setupView() {
        episodeTableView.dataSource = self
        episodeTableView.delegate = self
    }
}

extension EpisodeDetailView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let episodeModel = presenter.episodeModel else {
            return 0
        }
        return episodeModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharactersCell", for: indexPath)
        guard let episodeModel = presenter.episodeModel else {
            return cell
        }
        let episode = episodeModel.characters[indexPath.row]
        cell.textLabel?.text = episode
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let episodeModel = presenter.episodeModel else {
            return "CHARACTERS"
        }
        return "CHARACTERS (\(episodeModel.characters.count))"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white 
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = "CHARACTERS (\(presenter.episodeModel?.characters.count ?? 0))"
        
        headerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }
}

extension EpisodeDetailView: EpisodeDetailPresenterUI {
    func updateUI(viewModel: EpisodeDetailViewModel) {
        episodeName.text = viewModel.name
        let statusSectionTitleLabel = createTitleSection(title: "INFO")
        view.addSubview(statusSectionTitleLabel)
        let airDateStackView = createInfoStackView(title: "📅 Air Date", value: viewModel.airDate)
        let episodeStackView = createInfoStackView(title: "📺 Episode", value: viewModel.episode)
        
        view.addSubview(episodeName)
        view.addSubview(statusSectionTitleLabel)
        view.addSubview(airDateStackView)
        view.addSubview(episodeStackView)
        view.addSubview(episodeTableView)
        
        
        episodeName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            episodeName.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            episodeName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            episodeName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        statusSectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusSectionTitleLabel.topAnchor.constraint(equalTo: episodeName.bottomAnchor, constant: 20),
            statusSectionTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statusSectionTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        airDateStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            airDateStackView.topAnchor.constraint(equalTo: statusSectionTitleLabel.bottomAnchor, constant: 10),
            airDateStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            airDateStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        episodeStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            episodeStackView.topAnchor.constraint(equalTo: airDateStackView.bottomAnchor, constant: 8),
            episodeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            episodeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        
        episodeTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            episodeTableView.topAnchor.constraint(equalTo: episodeStackView.bottomAnchor, constant: 8),
            episodeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            episodeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            episodeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        self.episodeTableView.reloadData()
    }
}

