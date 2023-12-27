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
    
    private let searchController = UISearchController()
    
    private lazy var filterButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: #selector(filterButtonTapped))
        return button
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
        setupNavigationBar()
        setupTableView()
        presenter.onViewAppear()
        
        self.navigationItem.title = "Characters"
        
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = filterButton
    }
    
    private func setupTableView() {
        view.addSubview(charactersTableView)
        
        
        NSLayoutConstraint.activate([
            charactersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            charactersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            charactersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            charactersTableView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Characters"
        navigationItem.searchController = searchController
        
        
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
        
    }
    
    @objc private func filterButtonTapped() {
        presenter.handleFilterButtonTap()
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

extension CharactersListView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text else { return }
        if(searchText.count > 0) {
            let filteredCharacters = presenter.charactersModels.filter { character in
                return character.name.lowercased().contains(searchText.lowercased()) ||
                character.species.lowercased().contains(searchText.lowercased()) ||
                character.status.lowercased().contains(searchText.lowercased())
            }
            
            presenter.updateFilteredCharacters(filteredCharacters)
        }
    }
}

extension CharactersListView: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.updateFilteredCharacters(presenter.charactersModels)
        self.view.endEditing(true)
        
    }
}

extension CharactersListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.filteredCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCellView", for: indexPath) as! CharacterCellView
        let model = presenter.filteredCharacters[indexPath.row]
        
        cell.configure(model: model)
        return cell
    }
}

extension CharactersListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.onTapCell(atIndex: indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - screenHeight {
            presenter.loadMoreData()
        }
    }
}
