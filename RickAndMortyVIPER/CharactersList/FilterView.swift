//
//  FilterView.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation
import UIKit

class FilterView: UIViewController {

    private let presenter: CharactersListPresentable

    private let statusPicker = UIPickerView()
    private let genderPicker = UIPickerView()
    private let resetFiltersButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Borrar filtros", for: .normal)
        button.addTarget(self, action: #selector(resetFiltersButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(presenter: CharactersListPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        view.backgroundColor = .detailBackground

        statusPicker.dataSource = self
        statusPicker.delegate = self

        genderPicker.dataSource = self
        genderPicker.delegate = self
        view.addSubview(statusPicker)
        view.addSubview(genderPicker)
        view.addSubview(resetFiltersButton)
    }

    private func setupConstraints() {
        statusPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusPicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
        ])
        
        genderPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genderPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            genderPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            genderPicker.topAnchor.constraint(equalTo: statusPicker.bottomAnchor)
        ])
        
        resetFiltersButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resetFiltersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resetFiltersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resetFiltersButton.topAnchor.constraint(equalTo: genderPicker.bottomAnchor, constant: 20),
        ])
    }

    @objc private func resetFiltersButtonTapped() {
        presenter.resetFilters()
        dismiss(animated: true, completion: nil)

    }
}

extension FilterView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == statusPicker {
            return presenter.charactersStatus.count + 1
        } else if pickerView == genderPicker {
            return presenter.charactersGender.count + 1
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return "Selecciona un \(pickerView == statusPicker ? "status" : "gender")"
        } else {
            return pickerView == statusPicker ? presenter.charactersStatus[row - 1] : presenter.charactersGender[row - 1]
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == statusPicker {
            presenter.selectedStatusIndex = row - 1
        } else if pickerView == genderPicker {
            presenter.selectedGenderIndex = row - 1
        }
        presenter.filterCharacters()
        dismiss(animated: true, completion: nil)
    }
}
