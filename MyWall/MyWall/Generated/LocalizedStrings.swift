// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// Add
  internal static let addCostButton = L10n.tr("Localizable", "addCostButton")
  /// Cancel
  internal static let cancelButton = L10n.tr("Localizable", "cancelButton")
  /// Beauty
  internal static let costCategoryBeauty = L10n.tr("Localizable", "costCategory_beauty")
  /// Car service
  internal static let costCategoryCarService = L10n.tr("Localizable", "costCategory_carService")
  /// Children expenses
  internal static let costCategoryChildrenExpenses = L10n.tr("Localizable", "costCategory_childrenExpenses")
  /// Communal payments
  internal static let costCategoryCommunalPayments = L10n.tr("Localizable", "costCategory_communalPayments")
  /// Eat out
  internal static let costCategoryEatOuts = L10n.tr("Localizable", "costCategory_eatOuts")
  /// Education
  internal static let costCategoryEducation = L10n.tr("Localizable", "costCategory_education")
  /// Fare
  internal static let costCategoryFare = L10n.tr("Localizable", "costCategory_fare")
  /// Food
  internal static let costCategoryFoodProducts = L10n.tr("Localizable", "costCategory_foodProducts")
  /// Fuel
  internal static let costCategoryFuel = L10n.tr("Localizable", "costCategory_fuel")
  /// Gifts
  internal static let costCategoryGifts = L10n.tr("Localizable", "costCategory_gifts")
  /// Home improvement
  internal static let costCategoryHomeImprovement = L10n.tr("Localizable", "costCategory_homeImprovement")
  /// Household appliances
  internal static let costCategoryHouseholdAppliances = L10n.tr("Localizable", "costCategory_householdAppliances")
  /// Household goods
  internal static let costCategoryHouseholdGoods = L10n.tr("Localizable", "costCategory_householdGoods")
  /// Insurance
  internal static let costCategoryInsurance = L10n.tr("Localizable", "costCategory_insurance")
  /// Internet
  internal static let costCategoryInternet = L10n.tr("Localizable", "costCategory_internet")
  /// Loans
  internal static let costCategoryLoans = L10n.tr("Localizable", "costCategory_loans")
  /// Medication
  internal static let costCategoryMedication = L10n.tr("Localizable", "costCategory_medication")
  /// Mobile telefony
  internal static let costCategoryMobileTelefony = L10n.tr("Localizable", "costCategory_mobileTelefony")
  /// No category
  internal static let costCategoryNoCategory = L10n.tr("Localizable", "costCategory_noCategory")
  /// Parent expenses
  internal static let costCategoryParentExpenses = L10n.tr("Localizable", "costCategory_parentExpenses")
  /// Recreation
  internal static let costCategoryRecreation = L10n.tr("Localizable", "costCategory_recreation")
  /// Rent
  internal static let costCategoryRent = L10n.tr("Localizable", "costCategory_rent")
  /// Repairs
  internal static let costCategoryRepairs = L10n.tr("Localizable", "costCategory_repairs")
  /// Sport
  internal static let costCategorySport = L10n.tr("Localizable", "costCategory_sport")
  /// Treatment
  internal static let costCategoryTreatment = L10n.tr("Localizable", "costCategory_treatment")
  /// Wear
  internal static let costCategoryWear = L10n.tr("Localizable", "costCategory_wear")
  /// Expenses
  internal static let costs = L10n.tr("Localizable", "costs")
  /// Finish
  internal static let finishButton = L10n.tr("Localizable", "finishButton")
  /// Graphics
  internal static let home = L10n.tr("Localizable", "home")
  /// Incomes
  internal static let incomes = L10n.tr("Localizable", "incomes")
  /// Cost
  internal static let spent = L10n.tr("Localizable", "spent")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
