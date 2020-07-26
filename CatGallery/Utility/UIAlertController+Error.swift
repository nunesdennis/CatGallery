//
//  UIAlertController+Error.swift
//  CatGallery
//
//  Created by Dennis Nunes on 26/07/20.
//  Copyright © 2020 Dennis Nunes. All rights reserved.
//

import UIKit

extension UIAlertController {

	static func createAlert(with error: Error, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertTitle = "Error"
        let alertMessage = error.localizedDescription
        
		let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Retry", style: .cancel, handler: handler)
        alert.addAction(action)

        return alert
    }
}
