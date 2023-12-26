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
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let characterName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 32,
                                 weight: .bold,
                                 width: .condensed)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let characterStatus: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12,
                                 weight: .regular,
                                 width: .standard)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let characterSpecie: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12,
                                 weight: .regular,
                                 width: .standard)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(presenter: CharacterDetailPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .gray
        setupView()
        presenter.onViewAppear()
    }
    
    func setupView() {
        view.addSubview(characterImageView)
        view.addSubview(characterName)
        view.addSubview(characterStatus)
        view.addSubview(characterSpecie)
        
        NSLayoutConstraint.activate([
            characterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            characterImageView.heightAnchor.constraint(equalToConstant: 200),
            characterImageView.widthAnchor.constraint(equalToConstant: 300),
            

            characterName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            characterName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            characterName.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 20),
            
            characterStatus.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            characterStatus.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            characterStatus.topAnchor.constraint(equalTo: characterName.bottomAnchor, constant: 20),
            
            characterSpecie.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            characterSpecie.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            characterSpecie.topAnchor.constraint(equalTo: characterStatus.bottomAnchor, constant: 20)

        ])
    }
}

extension CharacterDetailView: CharacterDetailPresenterUI {
    func updateUI(viewModel: CharacterDetailViewModel) {
        characterImageView.kf.setImage(with: viewModel.image)
        characterName.text = viewModel.name
        characterStatus.text = viewModel.status
        characterSpecie.text = viewModel.species
    }
    
    
}
