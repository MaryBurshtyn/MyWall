import Foundation

enum CostCategory {
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
    
    var rawValue: String {
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
}
