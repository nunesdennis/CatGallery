//
//  CatImageView.swift
//  CatGallery
//
//  Created by Dennis Nunes on 26/07/20.
//  Copyright © 2020 Dennis Nunes. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CatImageView: UIImageView {
	
	private var sessionTask: URLSessionDataTask?
	
	func cancelLoading() {
		sessionTask?.cancel()
	}
	
	func loadImage(withId id:String, andURL url: URL) {
		
		let id = id as NSString
		
		if let imageFromCache = imageCache.object(forKey: id) {
			DispatchQueue.main.async {
				self.image = imageFromCache
			}
			return
		}
		
		sessionTask = URLSession.shared.dataTask(with: url) { data, response, error in

			DispatchQueue.main.async {
				if error != nil {
					return
				}
				
				if let data = data, let image = UIImage(data: data) {
					imageCache.setObject(image, forKey: id)
					self.image = image
				}
			}
		}
		
		sessionTask?.resume()
	}
}
