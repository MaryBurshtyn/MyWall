import Foundation
import UIKit

class AddIncomeAlertView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var incomeTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var addIncomeButton: UIButton!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    var delegate: AddIncomeAlertViewDelegate?
    var addedIncomes = [IncomeDB]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryPicker.delegate = self
        self.categoryPicker.dataSource = self
        self.currencyPicker.delegate = self
        self.currencyPicker.dataSource = self
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
        incomeLabel.text = L10n.spent
        addIncomeButton.titleLabel?.text = L10n.addCostButton
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
        let nib = UINib(nibName: "IncomeTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "IncomeTableViewCell")
    }
    
    @IBAction func addIncomeTapped(_ sender: Any) {
        guard let category = IncomeCategory.init(rawValue: categoryPicker.selectedRow(inComponent: 0)),
            let currency = Currency.init(rawValue: currencyPicker.selectedRow(inComponent: 0)),
            let income = incomeTextField.text else { return }
        var incomeDB = IncomeDB()
        incomeDB.category = category.stringValue
        incomeDB.date = Date()
        incomeDB.value = income
        incomeDB.currency = currency.stringValue
        addedIncomes.append(incomeDB)
        tableView.reloadData()
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okTapped(_ sender: Any) {
        delegate?.okButtonTapped(incomes: addedIncomes)
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView.tag == 1 ? 5 : 8
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView.tag == 1 ? Currency.init(rawValue: row)?.stringValue : IncomeCategory.init(rawValue: row)?.stringValue
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(font: FontFamily.Montserrat.semiBold, size: 12)
            pickerLabel?.textColor = .blue
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = pickerView.tag == 1 ? Currency.init(rawValue: row)?.stringValue : IncomeCategory.init(rawValue: row)?.stringValue

        return pickerLabel!
    }
}
extension AddIncomeAlertView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedIncomes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IncomeTableViewCell", for: indexPath) as? IncomeTableViewCell else {
                return UITableViewCell()
        }
        cell.configureCell(data: addedIncomes[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

