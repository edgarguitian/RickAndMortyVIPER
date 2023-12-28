//
//  LocationDetailResidentCellView.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation
import UIKit
import Kingfisher

class LocationDetailResidentCellView: UITableViewCell {
    let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
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
        addSubview(chevronImageView)

        let padding: CGFloat = 8

        NSLayoutConstraint.activate([
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            characterImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            characterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            characterImageView.widthAnchor.constraint(equalToConstant: 50),
            characterImageView.heightAnchor.constraint(equalToConstant: 50),

            characterName.centerYAnchor.constraint(equalTo: characterImageView.centerYAnchor),
            characterName.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 8),
            characterName.trailingAnchor.constraint(equalTo: trailingAnchor),

            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: 10),
            chevronImageView.heightAnchor.constraint(equalToConstant: 10)
        ])
    }

}
