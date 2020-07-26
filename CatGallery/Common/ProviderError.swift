//
//  ProviderError.swift
//  CatGallery
//
//  Created by Dennis Nunes on 26/07/20.
//  Copyright © 2020 Dennis Nunes. All rights reserved.
//

import Foundation

enum ProviderError: Error {
    case emptyResponse
    case invalidUrlFormat
    case parsingError
    case requestFailed
    case requestCodeFailed
    case unableToGenerateUrl
    case unknownError
}

typealias ProviderResult<T> = Result<T, ProviderError>
