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
    
    private lazy var optionsButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Options", style: UIBarButtonItem.Style.done, target: self, action: #selector(didPressOptionsButton))
        return button
    }()
    
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
        
        navigationItem.rightBarButtonItem = optionsButton
        
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
        characterDetailTableView.registerCell(of: CharacterContentTableViewCell.self)
        characterDetailTableView.registerCell(of: MessageTableViewCell.self)
        characterDetailTableView.registerCell(of: ActionTableViewCell.self)
    }
    
    @objc func didPressOptionsButton() {
        viewModel.showOptions {
            self.characterDetailTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        }
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
        
        let model = viewModel.viewModelForCell(at: indexPath)
        
        switch model {
        case let dto as CharacterDetailHeaderTableViewCellDTO:
            return table(tableView, headerCellAt: indexPath, with: dto)
        case let dto as CharacterContentTableViewCellDTO:
            return table(tableView, contentCellAt: indexPath, with: dto)
        case let dto as MessageTableViewCellDTO:
            return table(tableView, messageCellAt: indexPath, with: dto)
        case let dto as ActionTableViewCellDTO:
            return table(tableView, actionCellAt: indexPath, with: dto)
        default:
            return UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        switch cell {
        case _ as ActionTableViewCell:
            
            let section = viewModel.characterDetailSection(at: indexPath)
            let animation = UITableView.RowAnimation.fade
            
            tableView.beginUpdates()
            
            if section.preview {
                tableView.insertRows(at: viewModel.updatePreviewForContent(at: indexPath), with: animation)
            } else {
                tableView.deleteRows(at: viewModel.updatePreviewForContent(at: indexPath), with: animation)
            }
            
            tableView.endUpdates()
            
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeader(at: section)
    }

}

private extension CharacterDetailViewController {
    
    func table(_ tableView: UITableView, messageCellAt indexPath: IndexPath, with viewModel: MessageTableViewCellDTO?) -> MessageTableViewCell {
        let cell = tableView.dequeueReusableCell(MessageTableViewCell.self, for: indexPath)
        cell.configure(with: viewModel)
        return cell
    }
    
    func table(_ tableView: UITableView, actionCellAt indexPath: IndexPath, with viewModel: ActionTableViewCellDTO?) -> ActionTableViewCell {
        let cell = tableView.dequeueReusableCell(ActionTableViewCell.self, for: indexPath)
        cell.configure(with: viewModel)
        return cell
    }
    
    func table(_ tableView: UITableView, contentCellAt indexPath: IndexPath, with viewModel: CharacterContentTableViewCellDTO?) -> CharacterContentTableViewCell {
        let cell = tableView.dequeueReusableCell(CharacterContentTableViewCell.self, for: indexPath)
        cell.configure(with: viewModel)
        return cell
    }
    
    func table(_ tableView: UITableView, headerCellAt indexPath: IndexPath, with viewModel: CharacterDetailHeaderTableViewCellDTO?) -> CharacterDetailHeaderTableViewCell {
        let cell = tableView.dequeueReusableCell(CharacterDetailHeaderTableViewCell.self, for: indexPath)
        cell.configure(with: viewModel)
        return cell
    }
    
}
