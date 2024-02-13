//
//  DetailInfoViewController.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 13.02.2024.
//

import UIKit
/// Протокол главного экрана приложения.
protocol IDetailViewController: AnyObject {
	
	/// Метод отрисовки информации на экране.
	/// - Parameter viewModel: данные для отрисовки на экране.
	func render(viewData: RandomImagesModel.ViewData)
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
//	private var viewData = DetailModel.ViewData(images: [])
	
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

// MARK: - Setup UI
private extension DetailViewController {
	func setupUI() {
		title = L10n.DetailScreen.title
		view.backgroundColor = Theme.backgroundColor
	}
	
	//	func makeCollectionView() -> UICollectionView {
	//		let layout = UICollectionViewFlowLayout()
	//
	//		let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
	//		collection.backgroundColor = Theme.backgroundColor
	//		collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
	//		collection.translatesAutoresizingMaskIntoConstraints = false
	//		collection.dataSource = self
	//		collection.delegate = self
	//
	//		return collection
	//	}
	//
	//	func configureCell(_ cell: UICollectionViewCell, with image: Image) {
	//		let contentConfiguration = cell.contentConfiguration
	//		cell.contentConfiguration = contentConfiguration
	//	}
}

// MARK: - Layout UI
private extension DetailViewController {
	func layout() {
		//		view.addSubview(collectionViewFoto)
		//
		//		let safeArea = view.safeAreaLayoutGuide
		//		NSLayoutConstraint.activate([
		//			collectionViewFoto.leadingAnchor.constraint(equalTo: view.leadingAnchor),
		//			collectionViewFoto.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		//			collectionViewFoto.topAnchor.constraint(equalTo: safeArea.topAnchor),
		//			collectionViewFoto.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -Sizes.Padding.normal)
		//		])
	}
}

// MARK: - IMainViewController
extension DetailViewController: IDetailViewController {
	
	func render(viewData: RandomImagesModel.ViewData) {
	}
}
