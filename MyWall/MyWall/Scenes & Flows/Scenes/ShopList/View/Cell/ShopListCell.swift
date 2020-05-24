import Foundation
import UIKit

class ShopListCell: UITableViewCell, NibLoadable {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var checkBox: UIImageView!
    @IBOutlet weak var shopListItem: UILabel!
    
    
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
    
    func configureCell(data: String) {
        shopListItem.text = data
        setupCellView()
    }
}
