//
//  CatsViewController.swift
//  CatGallery
//
//  Created by Dennis Nunes on 26/07/20.
//  Copyright © 2020 Dennis Nunes. All rights reserved.
//

import UIKit

class CatsViewController: UIViewController {
	
	private lazy var collectionView: UICollectionView = {
		let screenHeight = UIScreen.main.bounds.height
		let screenWidth = UIScreen.main.bounds.width
		
		let cellWidth = 180.0
		let cellHeight = 180.0
		
		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
		layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
		layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		layout.minimumInteritemSpacing = 10
		layout.scrollDirection = .vertical
		
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsMultipleSelection = false
		collectionView.register(CatCell.nib, forCellWithReuseIdentifier: CatCell.identifier)
		
        return collectionView
    }()
	
	private var viewModel: CatsViewModelProtocol
	private let paginationOffSet: Int = 5
	
	init(viewModel: CatsViewModelProtocol = CatsViewModel()) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		
		self.viewModel.delegate = self
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupUI()
		
		viewModel.fetchCats()
    }
	
	func setupUI() {
		navigationController?.navigationBar.topItem?.title = "Cat Gallery"
		navigationController?.navigationBar.prefersLargeTitles = true
		
		view.backgroundColor = .white
	    view.addSubview(collectionView)

        let guide: UILayoutGuide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: guide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor)
        ])
	}
}

extension CatsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		return viewModel.numberOfItemsInSection
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatCell.identifier, for: indexPath)

		guard let catCell = cell as? CatCell else { return cell }
		let catPresenter = viewModel.cellPresenter(for: indexPath)
		catCell.prepare(with: catPresenter)

		return catCell
	}
}

extension CatsViewController: CatsViewModelDelegate {
	
	func didUpdateCats() {
		DispatchQueue.main.async {
			self.collectionView.reloadData()
		}
	}
	
	func didReceiveError(_ error: ProviderError) {
		DispatchQueue.main.async {
			let alert = UIAlertController.createAlert(with: error) { [weak self] _ in
				self?.viewModel.retry()
			}

            self.present(alert, animated: true, completion: nil)
        }
	}
}
