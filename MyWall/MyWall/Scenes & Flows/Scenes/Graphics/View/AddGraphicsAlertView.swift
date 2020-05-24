//
//  AddGraphicsAlertView.swift
//  MyWall

import Foundation
import UIKit

class AddGraphicsAlertView: UIViewController {
    
    @IBOutlet weak var sumTypeLabel: UILabel!
    @IBOutlet weak var sumTypeControl: UISegmentedControl!
    @IBOutlet weak var timePeriodLabel: UILabel!
    @IBOutlet weak var timePeriodControl: UISegmentedControl!
    
    @IBOutlet weak var dataTypeControl: UISegmentedControl!
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var firstDate: UIButton!
    @IBOutlet weak var secondDate: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var plotButton: UIButton!
    @IBOutlet weak var alertView: UIView!
    
    var delegate: AddGraphicsAlertViewDelegate?
    var fDate: Date?
    var sDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
    }
    
    private func setupView() {
        setUpViewForExpenses()
        dataTypeControl.setTitle(L10n.costs, forSegmentAt: 0)
        dataTypeControl.setTitle(L10n.incomes, forSegmentAt: 1)
        
        alertView.layer.cornerRadius = 12
        cancelButton.titleLabel?.text = L10n.cancelButton
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        plotButton.titleLabel?.text = L10n.plot
        customView.isHidden = true
    }
    
    private func setUpViewForExpenses() {
        if sumTypeControl.numberOfSegments != 3 {
            sumTypeControl.insertSegment(with: nil, at: 2, animated: true)
        }
        sumTypeControl.setTitle(L10n.day, forSegmentAt: 0)
        sumTypeControl.setTitle(L10n.month, forSegmentAt: 1)
        sumTypeControl.setTitle(L10n.category, forSegmentAt: 2)
    }
    
    private func setUpViewForIncomes() {
        sumTypeControl.removeSegment(at: 2, animated: true)
        sumTypeControl.setTitle(L10n.month, forSegmentAt: 0)
        sumTypeControl.setTitle(L10n.category, forSegmentAt: 1)
    }
    
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func plotTapped(_ sender: Any) {
        switch dataTypeControl.selectedSegmentIndex {
        case 0:
            settingsForExpenses()
        default:
            settingsForIncomes()
        }
    }
    
    private func settingsForExpenses() {
        guard let sumType = SumType.init(rawValue: sumTypeControl.selectedSegmentIndex) else {
            return
        }
        var period = TimePeriod.week
        switch sumType {
        case .day, .category:
            switch timePeriodControl.selectedSegmentIndex {
            case 0:
                period = TimePeriod.week
            case 1:
                period = TimePeriod.month
            case 2:
                guard let first = fDate, let second = sDate else {return}
                period = TimePeriod.custom(first, second)
            default:
                return
            }
        case .month:
            switch timePeriodControl.selectedSegmentIndex {
            case 0:
                period = TimePeriod.quarter
            case 1:
                period = TimePeriod.year
            case 2:
                guard let first = fDate, let second = sDate else {return}
                period = TimePeriod.custom(first, second)
            default:
                return
            }
        }
        delegate?.plotButtonTapped(dataType: DataType.expenses, sumType: sumType, period: period)
        self.dismiss(animated: true, completion: nil)
    }
    
    private func settingsForIncomes() {
        guard let sumType = SumType.init(rawValue: sumTypeControl.selectedSegmentIndex + 1) else {
            return
        }
        var period = TimePeriod.week
        switch sumType {
        case .day:
            switch timePeriodControl.selectedSegmentIndex {
            case 0:
                period = TimePeriod.quarter
            case 1:
                period = TimePeriod.year
            case 2:
                guard let first = fDate, let second = sDate else {return}
                period = TimePeriod.custom(first, second)
            default:
                return
            }
        default:
            switch timePeriodControl.selectedSegmentIndex {
            case 0:
                period = TimePeriod.month
            case 1:
                period = TimePeriod.year
            case 2:
                guard let first = fDate, let second = sDate else {return}
                period = TimePeriod.custom(first, second)
            default:
                return
            }
        }
        delegate?.plotButtonTapped(dataType: DataType.incomes, sumType: sumType, period: period)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func secondDateTapped(_ sender: Any) {
        sDate = datePicker.date
        secondDate.setTitle(sDate?.dateWithDefaultFormat(), for: .normal)
    }
    
    @IBAction func firstDateTapped(_ sender: Any) {
        fDate = datePicker.date
        firstDate.setTitle(fDate?.dateWithDefaultFormat(), for: .normal)
    }
    
    @IBAction func sumTypeValueChanged(_ sender: Any) {
        setPeriodControl(sumTypeControl.selectedSegmentIndex)
    }
    
    @IBAction func dateTypeValueChanged(_ sender: Any) {
        switch dataTypeControl.selectedSegmentIndex {
        case 0:
            setUpViewForExpenses()
        default:
            setUpViewForIncomes()
        }
    }
    
    @IBAction func timePeriodValueChanged(_ sender: Any) {
        if timePeriodControl.selectedSegmentIndex == 2 {
            customView.isHidden = false
        } else {
            customView.isHidden = true
        }
    }
    
    private func setPeriodControl(_ index: Int) {
        switch index {
        case 0:
            if dataTypeControl.selectedSegmentIndex == 1 {
                timePeriodControl.setTitle(L10n.quarter, forSegmentAt: 0)
                timePeriodControl.setTitle(L10n.year, forSegmentAt: 1)
                timePeriodControl.setTitle(L10n.custom, forSegmentAt: 2)
            } else {
                timePeriodControl.setTitle(L10n.week, forSegmentAt: 0)
                timePeriodControl.setTitle(L10n.month, forSegmentAt: 1)
                timePeriodControl.setTitle(L10n.custom, forSegmentAt: 2)
            }
        case 1:
            if dataTypeControl.selectedSegmentIndex == 1 {
                timePeriodControl.setTitle(L10n.month, forSegmentAt: 0)
                timePeriodControl.setTitle(L10n.year, forSegmentAt: 1)
                timePeriodControl.setTitle(L10n.custom, forSegmentAt: 2)
            } else {
                timePeriodControl.setTitle(L10n.quarter, forSegmentAt: 0)
                timePeriodControl.setTitle(L10n.year, forSegmentAt: 1)
                timePeriodControl.setTitle(L10n.custom, forSegmentAt: 2)
            }
           
        case 2:
            timePeriodControl.setTitle(L10n.week, forSegmentAt: 0)
            timePeriodControl.setTitle(L10n.month, forSegmentAt: 1)
            timePeriodControl.setTitle(L10n.custom, forSegmentAt: 2)
        default:
            return
        }
    }
    
}
