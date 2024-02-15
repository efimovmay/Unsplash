//
//  FavoriteImageViewController.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 10.02.2024.
//

import UIKit
/// Протокол экрана избранных изображений.
protocol IFavoriteImagesViewController: AnyObject {
	
	/// Метод отрисовки информации на экране.
	/// - Parameter viewModel: данные для отрисовки на экране.
	func render(viewData: FavoriteImagesModel.ViewData)
}

final class FavoriteImagesViewController: UIViewController {
	
	// MARK: - Dependencies
	var presenter: IFavoriteImagesPresenter?
	
	// MARK: - Initialization
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Private properties
	private var viewData = FavoriteImagesModel.ViewData(images: [])
	
	private lazy var tableView: UITableView = makeTableView()
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		layout()
		presenter?.viewIsReady()
	}
}

// MARK: - UITableViewDelegate

extension FavoriteImagesViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		presenter?.didItemSelected(index: indexPath.item)
	}
	
	func tableView(
		_ tableView: UITableView,
		commit editingStyle: UITableViewCell.EditingStyle,
		forRowAt indexPath: IndexPath
	) {
		if editingStyle == .delete {
			presenter?.deleteImage(index: indexPath.row)
			viewData.images.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .automatic)
		}
	}
}

// MARK: - UITableViewDataSource
extension FavoriteImagesViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewData.images.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: FavoriteImageCell.cellIdentifier,
			for: indexPath
		) as? FavoriteImageCell else {
			return UITableViewCell()
		}
		cell.selectionStyle = .none
		
		cell.configureLabel(text: viewData.images[indexPath.item].author)
		presenter?.fetch(index: indexPath.item, completion: { data in
			cell.configureImage(image: UIImage(data: data) ?? .actions)
		})
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		Sizes.heigthRow
	}
}
// MARK: - Setup UI
private extension FavoriteImagesViewController {
	func makeTableView() -> UITableView {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}
	
	func setupUI() {
		title = L10n.FavoriteImagesScreen.title
		navigationController?.navigationBar.prefersLargeTitles = true
		view.backgroundColor = Theme.backgroundColor
		
		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(FavoriteImageCell.self, forCellReuseIdentifier: FavoriteImageCell.cellIdentifier)
		tableView.backgroundColor = Theme.backgroundColor
	}
}

// MARK: - Layout UI
private extension FavoriteImagesViewController {
	func layout() {
		view.addSubview(tableView)
		
		let safeArea = view.safeAreaLayoutGuide
		let newConstraints = [
			tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
		]
		NSLayoutConstraint.activate(newConstraints)
	}
}

// MARK: - IMainViewController
extension FavoriteImagesViewController: IFavoriteImagesViewController {
	func render(viewData: FavoriteImagesModel.ViewData) {
		self.viewData = viewData
		self.tableView.reloadData()
	}
}
