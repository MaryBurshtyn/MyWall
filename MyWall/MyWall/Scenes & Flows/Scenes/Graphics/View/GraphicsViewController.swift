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
    // MARK: - Init & Setup

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.handleViewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setupListNavigationBar()
        //presenter.handleViewWillAppear()
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
        
    }
    
    private func setupListNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = L10n.home
        navigationController?.navigationBar.isTranslucent = true

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
    
    private func setChart(dataPoints: [String], values: [Float]) {
        
            
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
}

extension GraphicsViewController: GraphicsViewProtocol {
    func setChartData(_ data: [(key: String, value: Float)]) {
        if data.count == 0 {
            barChartView.noDataText = L10n.chartNoData
        }
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<data.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(data[i].value))
          dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Bar Chart View")
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
    }
    
    func setProgress(incomes: Float, expenses: Float) {
        progressLabel.text = "\(String(expenses))/\(String(incomes))"
        remainingMoney.text = L10n.remainingMoney + String(incomes - expenses)
        progressView.setProgress(Float((expenses)/incomes), animated: true)
    }
    
    
}

extension GraphicsViewController: AddGraphicsAlertViewDelegate {
    func plotButtonTapped(sumType: SumType, period: TimePeriod) {
        presenter.handleSettingsChoosed(sumType: sumType, period: period)
    }
    
    
}
