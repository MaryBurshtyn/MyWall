//
//  AddCostAlertView.swift
//  MyWall
//
//  Created by Burshtyn, Mariya on 11.05.2020.
//  Copyright © 2020 Burshtyn, Mariya. All rights reserved.
//

import Foundation
import UIKit

class AddCostAlertView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var costTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var addCostButton: UIButton!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    var delegate: AddCostAlertViewDelegate?
    var addedExpenses = [Cost]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryPicker.delegate = self
        self.categoryPicker.dataSource = self
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
    }
    
    func setupView() {
        alertView.layer.cornerRadius = 12
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        costLabel.text = L10n.spent
        addCostButton.titleLabel?.text = L10n.addCostButton
        cancelButton.titleLabel?.text = L10n.cancelButton
        okButton.titleLabel?.text = L10n.finishButton
    }
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }
    
    private func registerCell() {
        let nib = UINib(nibName: "CostTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "CostTableViewCell")
    }
    
    @IBAction func addCostTapped(_ sender: Any) {
        guard let category = CostCategory.init(rawValue: categoryPicker.selectedRow(inComponent: 0)),
            let cost = costTextField.text else { return }
        addedExpenses.append(Cost(category: category, date: Date(), cost: cost, currency: "BYN"))
        tableView.reloadData()
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okTapped(_ sender: Any) {
        delegate?.okButtonTapped(costs: addedExpenses)
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 25
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CostCategory.init(rawValue: row)?.stringValue
    }
}
extension AddCostAlertView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedExpenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CostTableViewCell", for: indexPath) as? CostTableViewCell else {
                return UITableViewCell()
        }
        cell.configureCell(data: addedExpenses[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
