//
//  CharacterDetailView.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation
import UIKit
import Kingfisher

class CharacterDetailView: UIViewController {
    private let presenter: CharacterDetailPresentable
    
    let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 35
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let characterName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    var characterTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "EpisodeCell")
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
    
    init(presenter: CharacterDetailPresentable) {
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
        characterTableView.dataSource = self
        characterTableView.delegate = self
    }
}

extension CharacterDetailView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let characterModel = presenter.characterModel else {
            return 0
        }
        return characterModel.episode.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath)
        guard let characterModel = presenter.characterModel else {
            return cell
        }
        let episode = characterModel.episode[indexPath.row]
        cell.textLabel?.text = episode
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let characterModel = presenter.characterModel else {
            return "EPISODES"
        }
        return "EPISODES (\(characterModel.episode.count))"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white 
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = "EPISODES (\(presenter.characterModel?.episode.count ?? 0))"
        
        headerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }
}

extension CharacterDetailView: CharacterDetailPresenterUI {
    func updateUI(viewModel: CharacterDetailViewModel) {
        characterImageView.kf.setImage(with: viewModel.image)
        characterName.text = viewModel.name
        let statusSectionTitleLabel = createTitleSection(title: "INFO")
        view.addSubview(statusSectionTitleLabel)
        let statusStackView = createInfoStackView(title: "🟢 Status", value: viewModel.status)
        let speciesStackView = createInfoStackView(title: "🧬 Species", value: viewModel.species)
        let genderStackView = createInfoStackView(title: "👤 Gender", value: viewModel.gender)
        
        let locationSectionTitleLabel = createTitleSection(title: "LOCATION")
        view.addSubview(locationSectionTitleLabel)
        let originStackView = createInfoStackView(title: "📍 Origin", value: viewModel.origin)
        let locationStackView = createInfoStackView(title: "🗺 Location", value: viewModel.location)
        
        view.addSubview(characterImageView)
        view.addSubview(characterName)
        view.addSubview(statusSectionTitleLabel)
        view.addSubview(statusStackView)
        view.addSubview(speciesStackView)
        view.addSubview(genderStackView)
        view.addSubview(originStackView)
        view.addSubview(locationStackView)
        view.addSubview(characterTableView)
        
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            characterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterImageView.widthAnchor.constraint(equalToConstant: 300),
            characterImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        characterName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            characterName.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 8),
            characterName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            characterName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        statusSectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusSectionTitleLabel.topAnchor.constraint(equalTo: characterName.bottomAnchor, constant: 20),
            statusSectionTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statusSectionTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        statusStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusStackView.topAnchor.constraint(equalTo: statusSectionTitleLabel.bottomAnchor, constant: 10),
            statusStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statusStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        speciesStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            speciesStackView.topAnchor.constraint(equalTo: statusStackView.bottomAnchor, constant: 8),
            speciesStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            speciesStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        genderStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genderStackView.topAnchor.constraint(equalTo: speciesStackView.bottomAnchor, constant: 8),
            genderStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            genderStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        locationSectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationSectionTitleLabel.topAnchor.constraint(equalTo: genderStackView.bottomAnchor, constant: 30),
            locationSectionTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            locationSectionTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        originStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            originStackView.topAnchor.constraint(equalTo: locationSectionTitleLabel.bottomAnchor, constant: 8),
            originStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            originStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        locationStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationStackView.topAnchor.constraint(equalTo: originStackView.bottomAnchor, constant: 8),
            locationStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            locationStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        characterTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            characterTableView.topAnchor.constraint(equalTo: locationStackView.bottomAnchor, constant: 8),
            characterTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            characterTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            characterTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        self.characterTableView.reloadData()
    }
}
