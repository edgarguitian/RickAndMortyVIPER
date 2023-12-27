//
//  LocationsListView.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation
import UIKit

class LocationsListView: UIViewController {
    private let presenter: LocationsListPresentable
    
    var locationsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(LocationCellView.self, forCellReuseIdentifier: "LocationCellView")
        return tableView
    }()
    
    init(presenter: LocationsListPresentable) {
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
        
        self.navigationItem.title = "Locations"

    }
    
    private func setupTableView() {
        view.addSubview(locationsTableView)
        
        NSLayoutConstraint.activate([
            locationsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            locationsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            locationsTableView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        locationsTableView.dataSource = self
        locationsTableView.delegate = self
    }
}

extension LocationsListView: LocationsListUI {
    func update(locations: [LocationCellViewModel]) {
        print("Datos recibidos \(locationsTableView)")
        DispatchQueue.main.async {
            self.locationsTableView.reloadData()
        }
    }
}

extension LocationsListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.locationsModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCellView", for: indexPath) as! LocationCellView
        let model = presenter.locationsModels[indexPath.row]
        
        cell.configure(model: model)
        return cell
    }
}

extension LocationsListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.onTapCell(atIndex: indexPath.row)
    }
}
