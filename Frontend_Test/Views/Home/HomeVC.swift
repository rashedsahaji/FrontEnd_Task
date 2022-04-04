//
//  HomeVC.swift
//  Frontend_Test
//
//  Created by Big oh on 02/04/22.
//

import UIKit

protocol HomeViewController: UIViewController{
    var tableView: UITableView! {get set}
    var fetched:MyResult? { get set }
}
class HomeVC: UIViewController, HomeViewController{
    
    var viewModel: ObservableHomeVM!
    var uiVC: ObservableHomeUIVC!
    var fetched:MyResult?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uiVC.setupTableView()
            RestManger.shared.fetchData(from: "https://picsum.photos/v2/list", method: "GET") { [weak self] outout in
                switch outout {
                case .success(let data):
                    self?.fetched = data
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                        self?.tableView.isHidden = false
                    }
                case .failure(_):
                    break
                }
        }
    }
    
    class func `init`() -> HomeVC {
        let vc = UIStoryboard.home.instanceOf(viewController: HomeVC.self)!
        vc.uiVC = HomeUIVC(view: vc)
        return vc
    }
}
