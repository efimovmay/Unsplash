//
//  DetailInfoViewController.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 13.02.2024.
//

import UIKit
/// Протокол экрана детальной информации.
protocol IDetailViewController: AnyObject {
	
	/// Метод отрисовки информации на экране.
	/// - Parameter viewModel: данные для отрисовки на экране.
	func render(viewData: DetailModel.ViewData)
	
	/// Обновление кнопок добавления в избранное
	/// - Parameter isFaivorite: состояние изображения.
	func updateIsFavoriteButton(isFaivorite: Bool)
}

final class DetailViewController: UIViewController {
	// MARK: - Dependencies
	
	var presenter: IDetailPresenter?
	
	// MARK: - Initialization
	
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Private properties
	private lazy var imageFoto: UIImageView = makeImage()
	
	private lazy var stackViewDescription: UIStackView = makeStackView()
	private lazy var stackViewValue: UIStackView = makeStackView()
	private lazy var stackViewMain: UIStackView = makeStackView()
	
	private lazy var labelUserDescription: UILabel = makeLabel(text: L10n.DetailScreen.user)
	private lazy var labelCreatedAtDescription: UILabel = makeLabel(text: L10n.DetailScreen.createdAt)
	private lazy var labelLocationDescription: UILabel = makeLabel(text: L10n.DetailScreen.location)
	private lazy var labelDownloadsDescription: UILabel = makeLabel(text: L10n.DetailScreen.downloads)
	
	private lazy var labelUserValue: UILabel = makeLabel(text: "")
	private lazy var labelCreatedAtValue: UILabel = makeLabel(text: "")
	private lazy var labelLocationValue: UILabel = makeLabel(text: "")
	private lazy var labelDownloadsValue: UILabel = makeLabel(text: "")
	
	private lazy var buttonAddInFavotite: UIButton = makeAddButton()
	private lazy var buttonDelFavotite: UIButton = makeDelButton()
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		layout()
	}
}

// MARK: - Actions

private extension DetailViewController {
	@objc
	func addInFavorite() {
		presenter?.addInFavorite()
	}
}

private extension DetailViewController {
	@objc
	func delFavorite() {
		presenter?.deleteImage()
	}
}

// MARK: - Setup UI
private extension DetailViewController {
	func setupUI() {
		presenter?.viewIsReady()
		
		title = L10n.DetailScreen.title
		view.backgroundColor = Theme.backgroundColor
		
		stackViewDescription.axis = .vertical
		stackViewDescription.addArrangedSubview(labelUserDescription)
		stackViewDescription.addArrangedSubview(labelCreatedAtDescription)
		stackViewDescription.addArrangedSubview(labelLocationDescription)
		stackViewDescription.addArrangedSubview(labelDownloadsDescription)
		
		stackViewValue.axis = .vertical
		stackViewValue.addArrangedSubview(labelUserValue)
		stackViewValue.addArrangedSubview(labelCreatedAtValue)
		stackViewValue.addArrangedSubview(labelLocationValue)
		stackViewValue.addArrangedSubview(labelDownloadsValue)
		
		stackViewMain.axis = .horizontal
		stackViewMain.addArrangedSubview(stackViewDescription)
		stackViewMain.addArrangedSubview(stackViewValue)
	}
	
	func makeImage() -> UIImageView {
		let image = UIImageView()
		image.contentMode = .scaleAspectFit
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}
	
	func makeStackView() -> UIStackView {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = Sizes.Padding.normal
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}
	
	func makeLabel(text: String) -> UILabel {
		let label = UILabel()
		label.text = text
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}
	
	func makeAddButton() -> UIButton {
		let button = UIButton()
		button.configuration = .filled()
		button.configuration?.cornerStyle = .large
		button.configuration?.title = L10n.DetailScreen.addInFavorite
		button.configuration?.baseBackgroundColor = Theme.addInFavoriteButtonColor
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(addInFavorite), for: .touchUpInside)
		return button
	}
	
	func makeDelButton() -> UIButton {
		let button = UIButton()
		button.configuration = .filled()
		button.configuration?.cornerStyle = .large
		button.configuration?.title = L10n.DetailScreen.delFavorite
		button.configuration?.baseBackgroundColor = Theme.delFavoriteButtonColor
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(delFavorite), for: .touchUpInside)
		return button
	}
}

// MARK: - Layout UI

private extension DetailViewController {
	func layout() {
		view.addSubview(imageFoto)
		view.addSubview(stackViewMain)
		view.addSubview(buttonAddInFavotite)
		view.addSubview(buttonDelFavotite)
		
		let safeArea = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			imageFoto.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Sizes.Padding.normal),
			imageFoto.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Sizes.Padding.normal),
			imageFoto.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: Sizes.Padding.normal),
			imageFoto.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Sizes.L.widthMultiplier),
			
			stackViewMain.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Sizes.Padding.double),
			stackViewMain.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Sizes.Padding.double),
			stackViewMain.topAnchor.constraint(equalTo: imageFoto.bottomAnchor, constant: Sizes.Padding.normal),
			
			buttonAddInFavotite.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Sizes.Padding.double),
			buttonAddInFavotite.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Sizes.Padding.double),
			buttonAddInFavotite.topAnchor.constraint(equalTo: stackViewMain.bottomAnchor, constant: Sizes.Padding.normal),
			
			buttonDelFavotite.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Sizes.Padding.double),
			buttonDelFavotite.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Sizes.Padding.double),
			buttonDelFavotite.topAnchor.constraint(equalTo: stackViewMain.bottomAnchor, constant: Sizes.Padding.normal)
		])
	}
}

// MARK: - IMainViewController

extension DetailViewController: IDetailViewController {
	
	func render(viewData: DetailModel.ViewData) {
		labelUserValue.text = viewData.user
		labelCreatedAtValue.text = viewData.createdAt
		labelLocationValue.text = viewData.location
		labelDownloadsValue.text = viewData.downloads
		
		presenter?.fetch(url: viewData.photo, completion: { image in
			self.imageFoto.image = UIImage(data: image)?.roundedCornerImage(with: Sizes.cornerRadiusDouble)
		})
		updateIsFavoriteButton(isFaivorite: viewData.isFaivorite)
	}
	
	func updateIsFavoriteButton(isFaivorite: Bool) {
		buttonAddInFavotite.isHidden = isFaivorite
		buttonDelFavotite.isHidden = !isFaivorite
	}
}
