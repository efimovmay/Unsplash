//
//  ImageCell.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 11.02.2024.
//

import UIKit

final class ImageCell: UICollectionViewCell {
	static let reuseIdentifier = "ImageCell"
	
	// MARK: - Private Properties
	
	private lazy var imageView = makeImageView()
	
	// MARK: - Lyfecycle
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	// MARK: - Public Methods
	
	func configure(with image: UIImage) {
		imageView.image = image
	}
}

// MARK: - Setup View

private extension ImageCell {
	
	func makeImageView() -> UIImageView {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = Sizes.cornerRadius
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}
	
	func setupViews() {
		addSubview(imageView)
		
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: topAnchor),
			imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
			imageView.heightAnchor.constraint(equalTo: heightAnchor)
		])
	}
}
