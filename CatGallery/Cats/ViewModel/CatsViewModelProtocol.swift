//
//  CatsViewModelProtocol.swift
//  CatGallery
//
//  Created by Dennis Nunes on 26/07/20.
//  Copyright © 2020 Dennis Nunes. All rights reserved.
//

import UIKit

protocol CatsViewModelProtocol {
    var delegate: CatsViewModelDelegate? { get set }
    var numberOfItemsInSection: Int { get }
	
	func fetchCats()
	func retry()
	func cellPresenter(for indexPath: IndexPath) -> CatsCellPresenter
}

protocol CatsViewModelDelegate: AnyObject {
    func didUpdateCats()
    func didReceiveError(_ error: ProviderError)
}
