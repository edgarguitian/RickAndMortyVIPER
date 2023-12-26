//
//  CharacterCellView.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation
import UIKit
import Kingfisher

class CharacterCellView: UITableViewCell {
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
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20,
                                 weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let characterStatus: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14,
                                 weight: .medium)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let characterSpecie: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12,
                                 weight: .medium)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let chevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
    
    func setupViews() {
        addSubview(characterImageView)
        addSubview(characterName)
        addSubview(characterStatus)
        addSubview(characterSpecie)
        addSubview(chevronImageView)
        
        let padding: CGFloat = 8

        NSLayoutConstraint.activate([
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            characterImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            characterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            characterImageView.widthAnchor.constraint(equalToConstant: 100),
            characterImageView.heightAnchor.constraint(equalToConstant: 100),
            
            characterName.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            characterName.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 8),
            characterName.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            characterStatus.topAnchor.constraint(equalTo: characterName.bottomAnchor, constant: 4),
            characterStatus.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 8),
            
            characterSpecie.topAnchor.constraint(equalTo: characterStatus.bottomAnchor, constant: 4),
            characterSpecie.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 8),

            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: 10),
            chevronImageView.heightAnchor.constraint(equalToConstant: 10),
        ])
    }
    
    func configure(model: CharacterCellViewModel) {
        characterImageView.kf.setImage(with: model.imageURL)
        characterName.text = model.name
        characterStatus.text = model.status
        characterSpecie.text = model.species
    }
}
