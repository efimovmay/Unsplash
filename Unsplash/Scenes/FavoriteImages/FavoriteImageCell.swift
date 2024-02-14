//
//  FavoriteImageCell.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 14.02.2024.
//

import UIKit

final class FavoriteImageCell: UITableViewCell {
	static let cellIdentifier = "FavoriteImageCell"
	
	// MARK: - Private properties
	private lazy var imageViewFoto = makeImageView()
	private lazy var labelText = makeTextLabel()
	
	// MARK: - Initialization
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
		layoutSubviews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Lifecycle
	override func layoutSubviews() {
		super.layoutSubviews()
		layout()
	}
	
	// MARK: - Public methods
	func configureLabel(text: String) {
		tintColor = .darkGray
		labelText.text = text
	}
	
	func configureImage(image: UIImage) {
		imageViewFoto.image = image.roundedCornerImage(with: Sizes.cornerRadius)
	}
}

// MARK: - Setup UI
private extension FavoriteImageCell {
	func makeImageView() -> UIImageView {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		return imageView
	}
	
	func makeTextLabel() -> UILabel {
		let label = UILabel()
		label.textColor = .gray
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}
	
	func setupUI() {
		addSubview(imageViewFoto)
		addSubview(labelText)
	}
	
	func layout() {
		let newConstraints = [
			imageViewFoto.topAnchor.constraint(equalTo: topAnchor, constant: Sizes.Padding.normal),
			imageViewFoto.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.Padding.normal),
			imageViewFoto.heightAnchor.constraint(equalToConstant: Sizes.L.height),
			imageViewFoto.widthAnchor.constraint(equalTo: imageViewFoto.heightAnchor),
			imageViewFoto.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Sizes.Padding.normal),
			
			labelText.topAnchor.constraint(equalTo: topAnchor, constant: Sizes.Padding.normal),
			labelText.leadingAnchor.constraint(equalTo: imageViewFoto.trailingAnchor, constant: Sizes.Padding.normal),
			labelText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Sizes.Padding.normal)
		]
		NSLayoutConstraint.activate(newConstraints)
	}
}
