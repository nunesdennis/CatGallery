//
//  CatsProvider.swift
//  CatGallery
//
//  Created by Dennis Nunes on 26/07/20.
//  Copyright © 2020 Dennis Nunes. All rights reserved.
//

import Foundation

final class CatsProvider: CatsProviderProtocol {

    private let httpLayer: HTTPLayerProtocol

    init(httpLayer: HTTPLayerProtocol = HTTPLayer()) {
        self.httpLayer = httpLayer
    }
	
	func fetchCats(page: Int, resultHandler: @escaping FetchCatsResultHandler) {
		httpLayer.dataRequest(CatsEndPoint.requestCats(page: page)) { result in
            switch result {
            case .success(let data):
                
                do {
                    let decoder = JSONDecoder()
					
					let cats = try decoder.decode(CatsResponse.self, from: data)
					
                    resultHandler(.success(cats))
                } catch let error {
					print("Fetch cats Error - ", error)
                    resultHandler(.failure(ProviderError.parsingError))
                }
            case .failure(let error):
                resultHandler(.failure(error))
            }
        }
    }
}
