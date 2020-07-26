//
//  CatCell.swift
//  CatGallery
//
//  Created by Dennis Nunes on 26/07/20.
//  Copyright © 2020 Dennis Nunes. All rights reserved.
//

import UIKit

typealias CatsCellPresenter = (id: String, title: String, imageUrl: String)

class CatCell: UICollectionViewCell {
	
	static let identifier = "catCell"
    static let nib: UINib = UINib(nibName: "CatCell", bundle: Bundle.main)
	static let imageThread = DispatchQueue(label: "queuename", attributes: .concurrent)
	
	@IBOutlet weak var catImageView: CatImageView!
	@IBOutlet weak var titleLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
    }
	
	override func prepareForReuse() {
		catImageView.image = .catPlaceHolder
		catImageView.cancelLoading()
		titleLabel.text = ""
	}
	
	func prepare(with presenter: CatsCellPresenter) {
		titleLabel.text = presenter.title
		let id = presenter.id
		guard let imageUrl = URL(string: presenter.imageUrl) else { return }

		CatCell.imageThread.async {
			self.catImageView.loadImage(withId: id, andURL: imageUrl)
		}
	}
}
