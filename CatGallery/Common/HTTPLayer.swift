//
//  HTTPLayer.swift
//  CatGallery
//
//  Created by Dennis Nunes on 26/07/20.
//  Copyright © 2020 Dennis Nunes. All rights reserved.
//

import Foundation

protocol HTTPLayerProtocol {
    
    func dataRequest(_ endpoint: EndPointProtocol, resultHandler: @escaping (ProviderResult<Data>) -> Void)
}

struct HTTPLayer: HTTPLayerProtocol {

	private let urlSession: URLSession

    init(urlSession: URLSession = URLSession(configuration: .default)) {
        self.urlSession = urlSession
    }

    func dataRequest(_ endpoint: EndPointProtocol, resultHandler: @escaping (ProviderResult<Data>) -> Void) {
        var urlComponents = URLComponents(string: endpoint.base)

        urlComponents?.path = endpoint.path
        urlComponents?.query = endpoint.query
		
        guard let composedUrl = urlComponents?.url else {
            resultHandler(.failure(ProviderError.invalidUrlFormat))
            return
        }

        var request = URLRequest(url: composedUrl)

        request.httpMethod = endpoint.method
		request.allHTTPHeaderFields = endpoint.hearder
		
        let dataTask = urlSession.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
			
			guard error == nil else {
                resultHandler(.failure(.requestFailed))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                resultHandler(.failure(.unknownError))
                return
            }

            guard response.statusCode >= 200 && response.statusCode < 300 else {
                resultHandler(.failure(.requestCodeFailed))
                return
            }
			
            guard let data = data, !data.isEmpty else {
                resultHandler(.failure(ProviderError.emptyResponse))
                return
            }
			
            resultHandler(.success(data))
        }

        dataTask.resume()
    }
}
