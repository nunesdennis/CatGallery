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
	private var imageTask: URLSessionTask?
	
	@IBOutlet weak var catImageView: CatImageView!
	@IBOutlet weak var titleLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
    }
	
	override func prepareForReuse() {
		catImageView.image = .catPlaceHolder
		imageTask?.cancel()
        imageTask = nil
		titleLabel.text = ""
	}
	
	func prepare(with presenter: CatsCellPresenter) {
		titleLabel.text = presenter.title
		let imageStr = presenter.imageUrl

		CatCell.imageThread.sync {
			self.imageTask = self.catImageView.loadImage(imageString: imageStr)
		}
	}
}
