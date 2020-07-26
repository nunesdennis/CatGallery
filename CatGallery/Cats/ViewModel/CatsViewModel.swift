//
//  CatsViewModel.swift
//  CatGallery
//
//  Created by Dennis Nunes on 26/07/20.
//  Copyright © 2020 Dennis Nunes. All rights reserved.
//

import UIKit

final class CatsViewModel: CatsViewModelProtocol {
	
    private let catsProvider: CatsProviderProtocol
	private var cats: [Cat] = []
    private var isFetchingCats = false
    weak var delegate: CatsViewModelDelegate?

	init(catsProvider: CatsProviderProtocol = CatsProvider()) {
        self.catsProvider = catsProvider
    }
	
	func fetchCats() {
		guard !isFetchingCats else { return }
		isFetchingCats = true
		catsProvider.fetchCats(page: 1) { result in
			self.isFetchingCats = false
			switch result {
			case .success(let response):
				self.handleCatsRequestSuccess(response)
			case .failure(let error):
				self.handleCatsRequestError(error)
			}
		}
	}
	
	func retry() {
		fetchCats()
	}
	
	func cellPresenter(for indexPath: IndexPath) -> CatsCellPresenter {
		let position = indexPath.row
		let cat = cats[position]
		guard let catImgId = cat.images?.first?.id ,let catTitle = cat.title, let catImageUrl = cat.images?.first?.link else { return
			(id: "", title: "", imageUrl: "")
		}

		return (id: catImgId, title: catTitle, imageUrl: catImageUrl)
	}
	
	private func handleCatsRequestSuccess(_ response: CatsResponse) {
		DispatchQueue.main.async {
			self.cats = response.data.filter({
				self.verifyUrl(urlString: $0.images?.first?.link ?? "")
			})
			
			self.delegate?.didUpdateCats()
		}
    }
	
	private func verifyUrl (urlString: String?) -> Bool {
		if let urlString = urlString {
			guard urlString.contains("png") || urlString.contains("jpg") || urlString.contains("jpeg") else {
				return false
			}
			if let url = NSURL(string: urlString) {
				return UIApplication.shared.canOpenURL(url as URL)
			}
		}
		return false
	}

    private func handleCatsRequestError(_ error: ProviderError) {
		DispatchQueue.main.async {
			self.delegate?.didReceiveError(error)
		}
    }
}

extension CatsViewModel {
	
	var numberOfItemsInSection: Int {
		return cats.count
	}
}
