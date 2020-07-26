//
//  CatImageView.swift
//  CatGallery
//
//  Created by Dennis Nunes on 26/07/20.
//  Copyright © 2020 Dennis Nunes. All rights reserved.
//

import UIKit

class CatImageView: UIImageView {
	
	static let shared: URLSession = CatImageView.configureSession()

    static private func configureSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
		let oneMB = 1 * 1024 * 1024
        let eightyMB = 20 * 1024 * 1024
		
		let cache = URLCache(memoryCapacity: oneMB, diskCapacity: eightyMB, diskPath: nil)
        configuration.urlCache = cache
        
		return URLSession(configuration: configuration)
    }
	
	func loadImage(imageString: String) -> URLSessionTask?{
		
		guard let imageURL = URL(string: imageString) else {
            return nil
        }

        let imageDownloadTask = CatImageView.shared.dataTask(with: imageURL, completionHandler: { [weak self] (data, _, _) -> Void in
            guard let data = data, let image = UIImage(data: data), let self = self else {
                return
            }

            DispatchQueue.main.async {
                self.image = image
            }
        })
        imageDownloadTask.resume()

        return imageDownloadTask
	}
}
