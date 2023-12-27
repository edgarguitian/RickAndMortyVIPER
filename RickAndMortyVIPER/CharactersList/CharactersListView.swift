//
//  CharactersListView.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation
import UIKit

class CharactersListView: UIViewController {
    private let presenter: CharactersListPresentable
    
    var charactersTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CharacterCellView.self, forCellReuseIdentifier: "CharacterCellView")
        return tableView
    }()
    
    init(presenter: CharactersListPresentable) {
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
        
        self.navigationItem.title = "Characters"

    }
    
    private func setupTableView() {
        view.addSubview(charactersTableView)
        
        NSLayoutConstraint.activate([
            charactersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            charactersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            charactersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            charactersTableView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
    }
    
}

extension CharactersListView: CharactersListUI {
    func update(characters: [CharacterCellViewModel]) {
        print("Datos recibidos \(characters)")
        DispatchQueue.main.async {
            self.charactersTableView.reloadData()
        }
    }
}

extension CharactersListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.charactersModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCellView", for: indexPath) as! CharacterCellView
        let model = presenter.charactersModels[indexPath.row]
        
        cell.configure(model: model)
        return cell
    }
}

extension CharactersListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.onTapCell(atIndex: indexPath.row)
    }
}
