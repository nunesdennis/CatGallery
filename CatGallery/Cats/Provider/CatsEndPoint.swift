//
//  CatsEndPoint.swift
//  CatGallery
//
//  Created by Dennis Nunes on 26/07/20.
//  Copyright © 2020 Dennis Nunes. All rights reserved.
//

import Foundation

enum CatsEndPoint: EndPointProtocol {

	case requestCats(page: Int)

    var base: String {
        switch self {
        case .requestCats:
            return "https://api.imgur.com"
        }
    }

    var path: String {
        switch self {
        case .requestCats:
            return "/3/gallery/search/"
        }
    }

    var query: String {
        switch self {
		case .requestCats:
            return "q=cats"
        }
    }

    var method: String {
        switch self {
        case .requestCats:
            return "GET"
        }
    }
	
	var hearder: [String : String] {
		switch self {
		case .requestCats:
			return ["Authorization":"Client-ID 1ceddedc03a5d71"]
		}
	}
}
