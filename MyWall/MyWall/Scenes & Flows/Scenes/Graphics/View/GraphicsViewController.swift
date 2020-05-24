import Foundation
import UIKit
import MBProgressHUD
import Charts

class GraphicsViewController: UIViewController {
    var presenter: GraphicsPresenterProtocol! {
        didSet {
            guard oldValue == nil else {
                fatalError("Presenter can be set only once -- during assembling \(self.description)")
            }
        }
    }
    var appearanceConfig: AppearanceConfigProtocol! {
        didSet {
            guard oldValue == nil else {
                fatalError("AppearanceConfig can be set only once -- during assembling \(self.description)")
            }
        }
    }
    
    @IBOutlet weak var progressMoneyView: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var spentLabel: UILabel!
    @IBOutlet weak var gotLabel: UILabel!
    @IBOutlet weak var remainingMoney: UILabel!
    @IBOutlet weak var barChartView: BarChartView!
    var horizontalChart: HorizontalBarChartView?
    // MARK: - Init & Setup

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.handleViewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setupListNavigationBar()
    }

    private func setUpView() {
        progressMoneyView.layer.cornerRadius = 10
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 8)
        progressView.layer.cornerRadius = 8.0
        progressView.clipsToBounds = true
        progressView.layer.sublayers?[1].cornerRadius = 8
        progressView.subviews[1].clipsToBounds = true
        gotLabel.text = L10n.youGot
        spentLabel.text = L10n.spentMoney
        barChartView.noDataText = L10n.chartNoData
        setupHorizonyalChart()
    }
    
    private func setupListNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = L10n.home

        navigationItem.rightBarButtonItem = (UIBarButtonItem(
            image: #imageLiteral(resourceName: "add2"),
            style: .plain,
            target: self,
            action: #selector(handleRightNavigationItemTapped))
        )
    }

    @objc
    private func handleRightNavigationItemTapped() {
        openSettingsDialog()
    }
    
   private func setupHorizonyalChart() {
    horizontalChart = HorizontalBarChartView()
        horizontalChart?.isHidden = true
        guard let view = horizontalChart else {
            return
        }
        self.view.addSubview(view)
        horizontalChart?.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: progressMoneyView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 400).isActive = true
    
        //horizontalChart?.fitBars = true
        horizontalChart?.legend.enabled = false
        horizontalChart?.drawValueAboveBarEnabled = true
        horizontalChart?.animate(yAxisDuration: 1.5)
    }
    
    private func openSettingsDialog() {
        guard let settingsAlert = self.storyboard?.instantiateViewController(withIdentifier: "AddGraphicsAlertView") as? AddGraphicsAlertView else {
            return
        }
        settingsAlert.providesPresentationContextTransitionStyle = true
        settingsAlert.definesPresentationContext = true
        settingsAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        settingsAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        settingsAlert.delegate = self
        self.present(settingsAlert, animated: true, completion: nil)
    }
    
    private func setBarChartViewData(_ data: [(key: String, value: Float)]) {
        if data.count == 0 {
            barChartView.noDataText = L10n.chartNoData
            return
        }
        horizontalChart?.isHidden = true
        barChartView.isHidden = false
        var labels = [String]()
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<data.count {
            labels.append(data[i].key)
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(data[i].value))
          dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: labels)
        barChartView.xAxis.granularity = 1
        barChartView.data = chartData
        barChartView.legend.enabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
    }
    
    private func setHorizontalChartViewData(_ data: [(key: String, value: Float)]) {
        barChartView.isHidden = true
        if data.count == 0 {
            horizontalChart?.noDataText = L10n.chartNoData
            return
        }
        horizontalChart?.isHidden = false
        var labels = [String]()
        var values = [String]()
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<data.count {
            labels.append(data[i].key)
            values.append(String(data[i].value))
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(data[i].value))
         dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
        let chartData = BarChartData(dataSet: chartDataSet)
        let formatter = MyValueFormatter()
        formatter.data = data
        horizontalChart?.xAxis.valueFormatter = IndexAxisValueFormatter(values: values)
        horizontalChart?.xAxis.granularity = 1
        horizontalChart?.data = chartData
        horizontalChart?.data?.setValueFormatter(formatter)
        horizontalChart?.data?.setDrawValues(true)
        horizontalChart?.xAxis.drawGridLinesEnabled = false
    }
    
}

extension GraphicsViewController: GraphicsViewProtocol {
    func setChartData(_ data: [(key: String, value: Float)], for sumType: SumType) {
        switch sumType {
        case .day, .month:
            setBarChartViewData(data)
        case .category:
            setHorizontalChartViewData(data)
        }
    }
    
    func setProgress(incomes: Float, expenses: Float) {
        progressLabel.text = "\(String(expenses))/\(String(incomes))"
        remainingMoney.text = L10n.remainingMoney + String(incomes - expenses)
        progressView.setProgress(Float((expenses)/incomes), animated: true)
    }
    
    
}

extension GraphicsViewController: AddGraphicsAlertViewDelegate {
    func plotButtonTapped(dataType: DataType, sumType: SumType, period: TimePeriod) {
        presenter.handleSettingsChoosed(dataType: dataType, sumType: sumType, period: period)
    }
}

class MyValueFormatter: IValueFormatter {
    var index = 0
    var data: [(key: String, value: Float)] = [(key: String, value: Float)]()
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        let values = data.filter({ (element) -> Bool in
            Double(element.value) == value
        })
        
        var stringValue = values[index].key
        if values.count - 1 == index {
            stringValue = values[index].key
            index = 0
            return stringValue.count > 10 ? String(stringValue.split(separator: " ").first!) : stringValue
        }
        if values.count > 1 {index += 1}
        
        return stringValue.count > 10 ? String(stringValue.split(separator: " ").first!) : stringValue
    }
}
