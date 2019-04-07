//
//  CharacterDetailViewController.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 06/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import UIKit
import PureLayout

class CharacterDetailViewController: ViewController<UIView> {
    
    private lazy var characterDetailTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private let viewModel: CharacterDetailViewModel
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        viewModel.loadCharacterData()
        characterDetailTableView.reloadData()
    }
    
    override func buildViewHierarchy() {
        view.addSubview(characterDetailTableView)
    }
    
    override func setupConstraints() {
        characterDetailTableView.autoPinEdgesToSuperviewEdges()
    }
    
    private func registerCells() {
        characterDetailTableView.registerCell(of: CharacterDetailHeaderTableViewCell.self)
    }
}

extension CharacterDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch viewModel.section(at: indexPath) {
        case let .main(viewModel):
            
            guard let cell = tableView.dequeueReusableCell(CharacterDetailHeaderTableViewCell.self, for: indexPath) else {
                return UITableViewCell(style: .default, reuseIdentifier: "Cell")
            }
            
            cell.configure(with: viewModel)
            return cell
        default:
            return UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeader(at: section)
    }
}
