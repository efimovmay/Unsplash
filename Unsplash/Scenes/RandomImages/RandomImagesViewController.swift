//
//  RandomImagesViewController.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 10.02.2024.
//

import UIKit
/// Протокол главного экрана приложения.
protocol IRandomImagesViewController: AnyObject {
	
	/// Метод отрисовки информации на экране.
	/// - Parameter viewModel: данные для отрисовки на экране.
	func renderCollection(viewData: RandomImagesModel.ViewData)
}

final class RandomImagesViewController: UIViewController {
	// MARK: - Dependencies
	
	var presenter: IRandomImagesPresenter?
	
	// MARK: - Initialization
	
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Private properties
	private var viewData = RandomImagesModel.ViewData(images: [], count: 0)
	
	private lazy var collectionViewimage: UICollectionView = makeCollectionView()
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		presenter?.viewIsReady()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		layout()
	}
}

// MARK: - UICollectionvView
extension RandomImagesViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewData.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: ImageCell.reuseIdentifier,
			for: indexPath
		) as? ImageCell else {
			return UICollectionViewCell()
		}
		let imageData = presenter?.fetch(index: indexPath.item, completion: { data in
			cell.configure(with: UIImage(data: data) ?? .actions)
		})
		
//		if let imageData = viewData.images[indexPath.item].data {
//			cell.configure(with: UIImage(data: imageData) ?? .actions)
//		} else {
//			cell.configure(with: UIImage(systemName: "photo.fill.on.rectangle.fill") ?? .actions)
//		}
		
		return cell
	}
}

extension RandomImagesViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		
		let itemsPerRow: CGFloat = 2
		let paddingWidth = Sizes.Padding.half * (itemsPerRow + 1)
		let availableWidth = collectionView.frame.width - paddingWidth
		let widthPerItem = availableWidth / itemsPerRow
		return CGSize(width: widthPerItem, height: widthPerItem)
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		insetForSectionAt section: Int
	) -> UIEdgeInsets {
		
		return UIEdgeInsets(
			top: Sizes.Padding.half,
			left: Sizes.Padding.half,
			bottom: Sizes.Padding.half,
			right: Sizes.Padding.half
		)
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumLineSpacingForSectionAt section: Int
	) -> CGFloat {
		
		return Sizes.Padding.half
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumInteritemSpacingForSectionAt section: Int
	) -> CGFloat {
		
		return Sizes.Padding.half
	}
}
// MARK: - Setup UI
private extension RandomImagesViewController {
	func setupUI() {
		title = L10n.RandomImagesScreen.title
		navigationItem.setHidesBackButton(true, animated: true)
		navigationItem.backButtonDisplayMode = .minimal
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.backButtonDisplayMode = .minimal
		view.backgroundColor = Theme.backgroundColor
		
		collectionViewimage.dataSource = self
		collectionViewimage.delegate = self
	}
	
	func makeCollectionView() -> UICollectionView {
		let layout = UICollectionViewFlowLayout()
		
		let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collection.backgroundColor = .clear
		collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
		collection.translatesAutoresizingMaskIntoConstraints = false
		collection.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseIdentifier)
		return collection
	}
	
	func configureCell(_ cell: UICollectionViewCell, with image: Image) {
		let contentConfiguration = cell.contentConfiguration
		cell.contentConfiguration = contentConfiguration
	}
}

// MARK: - Layout UI
private extension RandomImagesViewController {
	func layout() {
		view.addSubview(collectionViewimage)
		
		let safeArea = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			collectionViewimage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionViewimage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionViewimage.topAnchor.constraint(equalTo: safeArea.topAnchor),
			collectionViewimage.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
		])
	}
}

// MARK: - IMainViewController
extension RandomImagesViewController: IRandomImagesViewController {
	
	func renderCollection(viewData: RandomImagesModel.ViewData) {
		self.viewData = viewData
		self.collectionViewimage.reloadData()
	}
}
