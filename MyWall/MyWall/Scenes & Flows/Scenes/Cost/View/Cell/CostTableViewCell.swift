import Foundation
import UIKit
class CostTableViewCell: UITableViewCell, NibLoadable {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setupCellView() {
        cellView.layer.cornerRadius = 10
        cellView.layer.shadowColor = UIColor.gray.cgColor
        cellView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cellView.layer.shadowRadius = 2
        cellView.layer.shadowOpacity = 0.3
        
    }
    
    func configureCell(data: CostDB) {
        setupCellView()
        guard let categoryString = data.category,
            let value = data.value,
            let currency = data.currency else { return }
        categoryLabel.text = data.category
        costLabel.text = "\(value) \(currency)"
        categoryImage.image = CostCategory(form: categoryString).icon
    }
}
