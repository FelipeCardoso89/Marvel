//
//  CharacterCatalogViewController.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 05/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import UIKit
import PureLayout

class CharacterCatalogViewController: ViewController<UIView>, UICollectionViewDataSource, UICollectionViewDelegate {

    private lazy var catalogCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 160.0, height: 200.0)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
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
    
    private func registerCells() {
        catalogCollectionView.registerCell(of: CatalogItemCollectionViewCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCharacters
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(CatalogItemCollectionViewCell.self, for: indexPath) {
            cell.configure(with: viewModel.catalogItemDTO(for: indexPath))
            return cell
        } else {
            return  UICollectionViewCell(frame: CGRect.zero)
        }
    }
}

extension CharacterCatalogViewController: CharacterCatalogViewModelDelegate {
    
    func didLoadCharacteres() {
        DispatchQueue.main.async {
            self.catalogCollectionView.reloadData()
        }
    }
    
}
