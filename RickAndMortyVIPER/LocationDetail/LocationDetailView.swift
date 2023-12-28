//
//  LocationDetailView.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation
import UIKit
import Kingfisher

class LocationDetailView: UIViewController {
    private let presenter: LocationDetailPresentable

    let locationName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }()

    var locationTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .detailBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(LocationDetailResidentCellView.self, forCellReuseIdentifier: "ResidentCell")
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

    init(presenter: LocationDetailPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init coder has not been implemented")
    }

    override func viewDidLoad() {
        view.backgroundColor = .detailBackground
        setupView()
        presenter.onViewAppear()
    }

    func setupView() {
        locationTableView.dataSource = self
        locationTableView.delegate = self
    }
}

extension LocationDetailView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let locationModel = presenter.locationModel else {
            return 0
        }
        return locationModel.residents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ResidentCell",
                                                    for: indexPath) as? LocationDetailResidentCellView {
            guard let locationModel = presenter.locationModel else {
                return cell
            }
            let resident = locationModel.residents[indexPath.row]
            cell.characterImageView.kf.setImage(with: resident.image)
            cell.characterName.text = resident.name
            cell.backgroundColor = .detailBackground
            return cell
        } else {
            fatalError("No se pudo hacer casting a ResidentCell")
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let locationModel = presenter.locationModel else {
            return "RESIDENTS"
        }
        return "RESIDENTS (\(locationModel.residents.count))"
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .detailBackground

        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "RESIDENTS (\(presenter.locationModel?.residents.count ?? 0))"

        headerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])

        return headerView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.onTapCell(atIndex: indexPath.row)
    }
}

extension LocationDetailView: LocationDetailPresenterUI {
    func updateUI(viewModel: LocationDetailViewModel) {
        locationName.text = viewModel.name
        let statusSectionTitleLabel = createTitleSection(title: "INFO")
        view.addSubview(statusSectionTitleLabel)
        let typeStackView = createInfoStackView(title: "🪐 Type", value: viewModel.type)
        let dimensionStackView = createInfoStackView(title: "✨ Dimension", value: viewModel.dimension)

        view.addSubview(locationName)
        view.addSubview(statusSectionTitleLabel)
        view.addSubview(typeStackView)
        view.addSubview(dimensionStackView)
        view.addSubview(locationTableView)

        locationName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            locationName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            locationName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        statusSectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusSectionTitleLabel.topAnchor.constraint(equalTo: locationName.bottomAnchor, constant: 20),
            statusSectionTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statusSectionTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        typeStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            typeStackView.topAnchor.constraint(equalTo: statusSectionTitleLabel.bottomAnchor, constant: 10),
            typeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            typeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        dimensionStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dimensionStackView.topAnchor.constraint(equalTo: typeStackView.bottomAnchor, constant: 8),
            dimensionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dimensionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        locationTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationTableView.topAnchor.constraint(equalTo: dimensionStackView.bottomAnchor, constant: 8),
            locationTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            locationTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            locationTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        self.locationTableView.reloadData()
    }
}
