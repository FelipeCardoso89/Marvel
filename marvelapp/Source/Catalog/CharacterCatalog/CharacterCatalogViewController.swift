//
//  CharacterCatalogViewController.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 05/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import UIKit
import PureLayout
import CCBottomRefreshControl

class CharacterCatalogViewController: ViewController<UIView>, UICollectionViewDataSource, UICollectionViewDelegate {

    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Search Characters"
        controller.searchBar.delegate = self
        return controller
    }()
    
    private lazy var loadingViewController: LoadingViewController = {
        return LoadingViewController.loadXib(from: nil)
    }()
    
    private lazy var bottomRefreshControl: UIRefreshControl = {
        let control = UIRefreshControl.newAutoLayout()
        control.triggerVerticalOffset = 100
        control.addTarget(self, action: #selector(loadNextPage), for: .valueChanged)
        return control
    }()
    
    private lazy var catalogCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 160.0, height: 200.0)
        layout.minimumInteritemSpacing = 16.0
        layout.minimumLineSpacing = 16.0
        layout.sectionInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private let viewModel: CharacterCatalogViewModel
    
    init(viewModel: CharacterCatalogViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        title = viewModel.title
        navigationItem.searchController = searchController
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.catalogCollectionView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadCharacters()
    }
    
    override func buildViewHierarchy() {
        view.addSubview(catalogCollectionView)
    }

    override func setupConstraints() {
        catalogCollectionView.autoPinEdgesToSuperviewEdges()
    }
    
    override func configureViews() {
        catalogCollectionView.bottomRefreshControl = bottomRefreshControl
    }
    
    private func registerCells() {
        catalogCollectionView.registerCell(of: CatalogItemCollectionViewCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCharacters
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.viewModel(at: indexPath) {
        case let dto as CatalogItemCollectionViewCellDTO:
            return table(collectionView, catalogCellAt: indexPath, with: dto)
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.detailForCharacter(at: indexPath)
    }
    
    @objc func loadNextPage() {
        viewModel.loadNextPage()
    }
}

private extension CharacterCatalogViewController {
    
    func table(_ collectionView: UICollectionView, catalogCellAt indexPath: IndexPath, with viewModel: CatalogItemCollectionViewCellDTO?) -> CatalogItemCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CatalogItemCollectionViewCell.self, for: indexPath)
        cell.indexPath = indexPath
        cell.delegate = self
        cell.configure(with: viewModel)
        return cell
    }
}

extension CharacterCatalogViewController: CatalogItemCollectionViewCellDelegate {
    
    func longPressCell(at indexPath: IndexPath) {
        viewModel.optionsForCharacter(at: indexPath) {
            DispatchQueue.main.async {
                self.catalogCollectionView.reloadItems(at: [indexPath])
            }
        }
    }
}

extension CharacterCatalogViewController: CharacterCatalogViewModelDelegate {
    
    func willStartLoad() {
        
        guard viewModel.isFirstLoad else {
            return
        }
        
        add(loadingViewController)
        loadingViewController.view.autoPinEdgesToSuperviewEdges()
    }
    
    func didFinsihLoad() {
        DispatchQueue.main.async {
            self.loadingViewController.remove()
            self.catalogCollectionView.bottomRefreshControl?.endRefreshing()
            self.catalogCollectionView.reloadData()
            
            if self.viewModel.numberOfCharacters == 0 {
                self.viewModel.showEmptyCharacterAlert()
            }
        }
    }
    
    func didFinsihLoad(with error: NSError) {
        self.viewModel.showAlert(with: error)
    }
}

extension CharacterCatalogViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
        viewModel.reset()
        
        DispatchQueue.main.async {
            self.searchController.dismiss(animated: true, completion: nil)
            self.catalogCollectionView.reloadData()
        }
        
        if let text = searchBar.text {
            viewModel.searchCharacter(with: text)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        viewModel.reset()
        
        DispatchQueue.main.async {
            self.searchController.dismiss(animated: true, completion: nil)
            self.catalogCollectionView.reloadData()
        }
        
        viewModel.loadCharacters()
    }
}
