//
//  IncomeTableViewCell.swift
//  MyWall
//
//  Created by Burshtyn, Mariya on 15.05.2020.
//  Copyright © 2020 Burshtyn, Mariya. All rights reserved.
//

import Foundation
import UIKit

class IncomeTableViewCell: UITableViewCell, NibLoadable {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var incomeLabel: UILabel!
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
    
    func configureCell(data: IncomeDB) {
        setupCellView()
        guard let categoryString = data.category,
        let value = data.value,
        let currency = data.currency else { return }
        categoryLabel.text = data.category
        incomeLabel.text = "\(value) \(currency)"
        categoryImage.image = IncomeCategory(from: categoryString).icon
    }
}
