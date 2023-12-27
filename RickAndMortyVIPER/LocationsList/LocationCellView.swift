//
//  LocationCellView.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation
import UIKit
import Kingfisher

class LocationCellView: UITableViewCell {
    let locationName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20,
                                 weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let locationType: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14,
                                 weight: .medium)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let locationDimension: UILabel = {
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
        addSubview(locationName)
        addSubview(locationType)
        addSubview(locationDimension)
        addSubview(chevronImageView)
        
        let padding: CGFloat = 8

        NSLayoutConstraint.activate([
            locationName.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            locationName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            locationName.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            locationType.topAnchor.constraint(equalTo: locationName.bottomAnchor, constant: 4),
            locationType.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            locationType.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding),

            locationDimension.topAnchor.constraint(equalTo: locationType.bottomAnchor, constant: 4),
            locationDimension.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            locationDimension.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding),
            locationDimension.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),

            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: 10),
            chevronImageView.heightAnchor.constraint(equalToConstant: 10),
        ])
    }
    
    func configure(model: LocationCellViewModel) {
        locationName.text = model.name
        locationType.text = model.type
        locationDimension.text = model.dimension
    }
}
