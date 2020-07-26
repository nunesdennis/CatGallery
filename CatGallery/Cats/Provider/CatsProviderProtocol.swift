//
//  CatsProviderProtocol.swift
//  CatGallery
//
//  Created by Dennis Nunes on 26/07/20.
//  Copyright © 2020 Dennis Nunes. All rights reserved.
//

import Foundation

typealias FetchCatsResultHandler = (ProviderResult<CatsResponse>) -> ()

protocol CatsProviderProtocol {
	func fetchCats(page: Int, resultHandler: @escaping FetchCatsResultHandler)
}
