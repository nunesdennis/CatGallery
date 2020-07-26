//
//  EndPointProtocol.swift
//  CatGallery
//
//  Created by Dennis Nunes on 26/07/20.
//  Copyright © 2020 Dennis Nunes. All rights reserved.
//

import Foundation

protocol EndPointProtocol {
    var base: String { get }
    var path: String { get }
    var query: String { get }
    var method: String { get }
	var hearder: [String: String] { get }
}
