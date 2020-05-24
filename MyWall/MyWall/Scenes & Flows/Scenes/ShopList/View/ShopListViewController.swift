import Foundation
import UIKit

class ShopListViewController: UIViewController {
    
    // MARK: - MVP Infractructure
    
    var presenter: ShopListPresenterProtocol! {
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
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Init & Setup

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupListNavigationBar()
    }

    private func registerCell() {
        let nib = UINib(nibName: "ShopListCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "ShopListCell")
    }

    private func setupListNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = L10n.shopListNavBar

        navigationItem.rightBarButtonItem = (UIBarButtonItem(
            image: #imageLiteral(resourceName: "add2"),
            style: .plain,
            target: self,
            action: #selector(handleRightNavigationItemTapped))
        )
    }

    @objc
    private func handleRightNavigationItemTapped() {
        
    }
    
}

extension ShopListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShopListCell", for: indexPath) as? ShopListCell else {
               return UITableViewCell()
        }
        cell.configureCell(data: "Water")
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }
}

extension ShopListViewController: ShopListViewProtocol {
    
}
