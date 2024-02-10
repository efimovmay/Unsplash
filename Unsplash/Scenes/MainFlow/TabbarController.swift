//
//  TabbarController.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 10.02.2024.
//

import UIKit

final class TabBarController: UITabBarController {
	
	// MARK: - LifeCycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}
}

private extension TabBarController {
	func setup() {
		let controllers: [UINavigationController] = TabbarPage.allTabbarPages.map { getTabController($0) }
		
		setViewControllers(controllers, animated: true)
		selectedIndex = TabbarPage.firstTabbarPage.pageOrderNumber
	}
	
	func getTabController(_ page: TabbarPage) -> UINavigationController {
		let navController = UINavigationController()
		
		navController.tabBarItem = UITabBarItem(
			title: page.pageTitleValue(),
			image: page.pageIconValue(),
			tag: page.pageOrderNumber
		)
		
		return navController
	}
}
