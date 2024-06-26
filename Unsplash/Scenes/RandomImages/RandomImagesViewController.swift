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
	
	private var viewData = RandomImagesModel.ViewData(images: [])
	
	private var isLoading = false
	private var isShowRandom = true
	
	private lazy var collectionViewimage: UICollectionView = makeCollectionView()
	private lazy var searchController: UISearchController = makeSearchController()
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		presenter?.fetchRandom()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		layout()
	}
}

// MARK: - Actions

private extension RandomImagesViewController {
	@objc
	func reload() {
		let alert = UIAlertController(
			title: L10n.RandomImagesScreen.titleAlert,
			message: L10n.RandomImagesScreen.textAlert,
			preferredStyle: .alert
		)
		alert.addAction(UIAlertAction(title: L10n.Yes.text, style: .destructive))
		alert.addAction(UIAlertAction(title: L10n.Ok.text, style: .default, handler: { _ in
			self.presenter?.fetchRandom()
		}))
		present(alert, animated: true, completion: nil)
	}
}

// MARK: - UICollectionViewDataSource

extension RandomImagesViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewData.images.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: ImageCell.reuseIdentifier,
			for: indexPath
		) as? ImageCell else {
			return UICollectionViewCell()
		}
		
		cell.configure(imageURL: viewData.images[indexPath.item].urls.small)
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		presenter?.didItemSelected(index: indexPath.item)
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		willDisplay cell: UICollectionViewCell,
		forItemAt indexPath: IndexPath
	) {
		if indexPath.row == viewData.images.count - 2 {
			if !isLoading {
				isLoading = true
				switch isShowRandom {
				case true:
					presenter?.fetchRandom()
				case false:
					presenter?.fetchNextPage()
				}
			}
		}
	}
}

// MARK: - UICollectionViewDelegateFlowLayout

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
// MARK: - UISearchBarDelegate

extension RandomImagesViewController: UISearchBarDelegate {
	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		isShowRandom = false
		if !isLoading {
			isLoading = true
			presenter?.fetchSearchImage(searchBy: searchBar.text ?? "", page: 1)
		}
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		isShowRandom = true
		if !isLoading {
			isLoading = true
			presenter?.fetchRandom()
		}
	}
}

// MARK: - Setup UI

private extension RandomImagesViewController {
	func setupUI() {
		title = L10n.RandomImagesScreen.title
		navigationController?.navigationBar.prefersLargeTitles = true
		view.backgroundColor = Theme.backgroundColor
		
		navigationItem.searchController = searchController
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .refresh,
			target: self,
			action: #selector(reload)
		)
		
		collectionViewimage.dataSource = self
		collectionViewimage.delegate = self
	}
	
	func makeSearchController() -> UISearchController {
		let searchController = UISearchController(searchResultsController: nil)
		searchController.searchBar.placeholder = L10n.RandomImagesScreen.seachPlaceholder
		searchController.searchBar.sizeToFit()
		searchController.searchBar.delegate = self
		return searchController
	}
	
	func makeCollectionView() -> UICollectionView {
		let layout = UICollectionViewFlowLayout()

		let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collection.backgroundColor = .clear
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
		isLoading = false
	}
}
