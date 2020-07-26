//
//  Cat.swift
//  CatGallery
//
//  Created by Dennis Nunes on 26/07/20.
//  Copyright © 2020 Dennis Nunes. All rights reserved.
//

import Foundation

struct CatsResponse: Codable {
	let data: [Cat]
	let success: Bool
	let status: Int
}

struct Image: Codable {
	let id: String?
	let link: String?
}

struct Cat: Codable {
    let id: String?
	let title: String?
	let images: [Image]?
}
