//
//  EpisodeCellView.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation
import UIKit
import Kingfisher

class EpisodeCellView: UITableViewCell {
    let episodeName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20,
                                 weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    let episodeDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14,
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
        addSubview(episodeName)
        addSubview(episodeDescription)
        addSubview(chevronImageView)

        let padding: CGFloat = 8

        NSLayoutConstraint.activate([
            episodeName.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            episodeName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            episodeName.trailingAnchor.constraint(equalTo: trailingAnchor),

            episodeDescription.topAnchor.constraint(equalTo: episodeName.bottomAnchor, constant: 4),
            episodeDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            episodeDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding),
            episodeDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),

            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: 10),
            chevronImageView.heightAnchor.constraint(equalToConstant: 10)
        ])
    }

    func configure(model: EpisodeCellViewModel) {
        episodeName.text = model.name
        episodeDescription.text = model.episode
    }
}
