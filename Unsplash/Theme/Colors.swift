//
//  Colors.swift
//  Notes
//
//  Created by Aleksey Efimov on 29.01.2024.
//

import UIKit

enum Colors {
	static let white = UIColor.color(
		light: UIColor(hex: 0xFFFFFF),
		dark: UIColor(hex: 0x000000)
	)
	static let black = UIColor.color(
		light: UIColor(hex: 0x000000),
		dark: UIColor(hex: 0xFFFFFF)
	)
	static let red = UIColor.color(
		light: UIColor(hex: 0xff0000),
		dark: UIColor(hex: 0xFF4040)
	)
}

enum Theme {
	static let backgroundColor = Colors.white
	static let addInFavoriteButtonColor = Colors.red
}
