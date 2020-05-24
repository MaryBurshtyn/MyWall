import Foundation
import UIKit

enum IncomeCategory: Int {
    case noCategory
    case debt
    case salary
    case pension
    case gratuity
    case scholarship
    case dividends
    case moneyPrize
    
    init(from stringValue: String) {
        switch stringValue {
        case L10n.incomeCategoryNoCategory:
            self = IncomeCategory.noCategory
        case L10n.incomeCategoryDebt:
            self = IncomeCategory.debt
        case L10n.incomeCategorySalary:
            self = IncomeCategory.salary
        case L10n.incomeCategoryPension:
            self = IncomeCategory.pension
        case L10n.incomeCategoryGratuity:
            self = IncomeCategory.gratuity
        case L10n.incomeCategoryScholarship:
            self = IncomeCategory.scholarship
        case L10n.incomeCategoryDividends:
            self = IncomeCategory.dividends
        case L10n.incomeCategoryMoneyPrize:
            self = IncomeCategory.moneyPrize
        default:
            self = IncomeCategory.noCategory
        }
    }

    var stringValue: String {
        switch self {
        case .noCategory:
            return L10n.incomeCategoryNoCategory
        case .debt:
            return L10n.incomeCategoryDebt
        case .salary:
            return L10n.incomeCategorySalary
        case .pension:
            return L10n.incomeCategoryPension
        case .gratuity:
            return L10n.incomeCategoryGratuity
        case .scholarship:
            return L10n.incomeCategoryScholarship
        case .dividends:
            return L10n.incomeCategoryDividends
        case .moneyPrize:
            return L10n.incomeCategoryMoneyPrize
        }
    }
    
    var icon: UIImage {
        switch self {
        case .noCategory:
            return #imageLiteral(resourceName: "noCategory")
        case .debt:
            return #imageLiteral(resourceName: "loans")
        case .salary:
            return #imageLiteral(resourceName: "salary")
        case .pension:
            return #imageLiteral(resourceName: "pension")
        case .gratuity:
            return #imageLiteral(resourceName: "gifts")
        case .scholarship:
            return #imageLiteral(resourceName: "education")
        case .dividends:
            return #imageLiteral(resourceName: "dividends")
        case .moneyPrize:
            return #imageLiteral(resourceName: "prize")
        }
    }
}
