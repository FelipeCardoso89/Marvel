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
        
        registerCells()
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
       
        let cell = collectionView.dequeueReusableCell(CatalogItemCollectionViewCell.self, for: indexPath)
       
        if let character = viewModel.character(at: indexPath)  {
            cell.configure(with: CatalogItemCollectionViewCellDTO(character: character))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.detailForCharacter(at: indexPath)
    }
    
    @objc func loadNextPage() {
        viewModel.loadNextPage()
    }
}

extension CharacterCatalogViewController: CharacterCatalogViewModelDelegate {
    func didFinsihLoad() {
        DispatchQueue.main.async {
            self.catalogCollectionView.bottomRefreshControl?.endRefreshing()
            self.catalogCollectionView.reloadData()
        }
    }
    
    func didFinsihLoad(with error: NSError) {
        print("\(error.localizedDescription)")
    }
}
