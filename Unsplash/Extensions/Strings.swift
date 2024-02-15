//
//  Strings.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 10.02.2024.
//
// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name

public enum L10n {
	
	public enum Error {
		public static let text = L10n.tr("Localizable", "Error.text")
	}
	
	public enum No {
		public static let text = L10n.tr("Localizable", "No.text")
	}
	
	public enum Ok {
		public static let text = L10n.tr("Localizable", "Ok.text")
	}
	
	public enum Return {
		public static let text = L10n.tr("Localizable", "Return.text")
	}
	
	public enum Yes {
		public static let text = L10n.tr("Localizable", "Yes.text")
	}
	
	public enum RandomImagesScreen {
		public static let title = L10n.tr("Localizable", "RandomImagesScreen.title")
		public static let titleAlert = L10n.tr("Localizable", "RandomImagesScreen.titleAlert")
		public static let textAlert = L10n.tr("Localizable", "RandomImagesScreen.textAlert")
	}
	
	public enum FavoriteImagesScreen {
		public static let title = L10n.tr("Localizable", "FavoriteImagesScreen.title")
	}
	
	public enum DetailScreen {
		public static let title = L10n.tr("Localizable", "DetailScreen.title")
		public static let user = L10n.tr("Localizable", "DetailScreen.user")
		public static let createdAt = L10n.tr("Localizable", "DetailScreen.createdAt")
		public static let location = L10n.tr("Localizable", "DetailScreen.location")
		public static let downloads = L10n.tr("Localizable", "DetailScreen.downloads")
		public static let addInFavorite = L10n.tr("Localizable", "DetailScreen.addInFavorite")
		public static let delFavorite = L10n.tr("Localizable", "DetailScreen.delFavorite")
	}
}

// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
	private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
		let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
		return String(format: format, locale: Locale.current, arguments: args)
	}
}

private final class BundleToken {}

// swiftlint:disable convenience_type
// swiftlint:enable all
// swiftformat:enable all
