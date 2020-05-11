import Foundation
import UIKit
enum CostCategory: Int {
    case noCategory
    case foodProducts
    case eatOuts
    case fare
    case internet
    case mobileTelefony
    case wear
    case gifts
    case recreation
    case householdGoods
    case communalPayments
    case childrenExpenses
    case parentExpenses
    case medication
    case treatment
    case sport
    case insurance
    case fuel
    case carService
    case rent
    case householdAppliances
    case repairs
    case homeImprovement
    case beauty
    case loans
    case education
    
    var stringValue: String {
        switch self {
        case .noCategory:
            return L10n.costCategoryNoCategory
        case .foodProducts:
            return L10n.costCategoryFoodProducts
        case .eatOuts:
            return L10n.costCategoryEatOuts
        case .fare:
            return L10n.costCategoryFare
        case .internet:
            return L10n.costCategoryInternet
        case .mobileTelefony:
            return L10n.costCategoryMobileTelefony
        case .wear:
            return L10n.costCategoryWear
        case .gifts:
            return L10n.costCategoryGifts
        case .recreation:
            return L10n.costCategoryRecreation
        case .householdGoods:
            return L10n.costCategoryHouseholdGoods
        case .communalPayments:
            return L10n.costCategoryCommunalPayments
        case .childrenExpenses:
            return L10n.costCategoryChildrenExpenses
        case .parentExpenses:
            return L10n.costCategoryParentExpenses
        case .medication:
            return L10n.costCategoryMedication
        case .treatment:
            return L10n.costCategoryTreatment
        case .sport:
            return L10n.costCategorySport
        case .insurance:
            return L10n.costCategoryInsurance
        case .fuel:
            return L10n.costCategoryFuel
        case .carService:
            return L10n.costCategoryCarService
        case .rent:
            return L10n.costCategoryRent
        case .householdAppliances:
            return L10n.costCategoryHouseholdAppliances
        case .repairs:
            return L10n.costCategoryRepairs
        case .homeImprovement:
            return L10n.costCategoryHomeImprovement
        case .beauty:
            return L10n.costCategoryBeauty
        case .loans:
            return L10n.costCategoryLoans
        case .education:
            return L10n.costCategoryEducation
        }
    }
    var icon: UIImage {
        switch self {
       case .noCategory:
            return #imageLiteral(resourceName: "noCategory")
        case .foodProducts:
            return #imageLiteral(resourceName: "foodProducts")
        case .eatOuts:
            return #imageLiteral(resourceName: "eatOuts")
        case .fare:
            return #imageLiteral(resourceName: "fare")
        case .internet:
            return #imageLiteral(resourceName: "internet")
        case .mobileTelefony:
            return #imageLiteral(resourceName: "mobileTelefony")
        case .wear:
            return #imageLiteral(resourceName: "wear")
        case .gifts:
            return #imageLiteral(resourceName: "gifts")
        case .recreation:
            return #imageLiteral(resourceName: "recreation")
        case .householdGoods:
            return #imageLiteral(resourceName: "householdGoods")
        case .communalPayments:
            return #imageLiteral(resourceName: "communalPayments")
        case .childrenExpenses:
            return #imageLiteral(resourceName: "childrenExpenses")
        case .parentExpenses:
            return #imageLiteral(resourceName: "parentExpenses")
        case .medication:
            return #imageLiteral(resourceName: "medication")
        case .treatment:
            return #imageLiteral(resourceName: "treatment")
        case .sport:
            return #imageLiteral(resourceName: "sport")
        case .insurance:
            return #imageLiteral(resourceName: "insurance")
        case .fuel:
            return #imageLiteral(resourceName: "fuel")
        case .carService:
            return #imageLiteral(resourceName: "carService")
        case .rent:
            return #imageLiteral(resourceName: "rent")
        case .householdAppliances:
            return #imageLiteral(resourceName: "householdAppliances")
        case .repairs:
            return #imageLiteral(resourceName: "repairs")
        case .homeImprovement:
            return #imageLiteral(resourceName: "homeImprovement")
        case .beauty:
            return #imageLiteral(resourceName: "beauty")
        case .loans:
            return #imageLiteral(resourceName: "loans")
        case .education:
            return #imageLiteral(resourceName: "education")
        }
    }
}
