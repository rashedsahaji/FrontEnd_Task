//
//  HomeUIVC.swift
//  Frontend_Test
//
//  Created by Big oh on 02/04/22.
//

import Foundation
import UIKit
protocol ObservableHomeUIVC: AnyObject {
    var view: HomeViewController? {get}
    func setupTableView()
}
class HomeUIVC: NSObject, ObservableHomeUIVC{
    
    weak var view: HomeViewController?
    private var imageCache = NSCache<AnyObject, UIImage>()
    
    init(view: HomeViewController) {
        super.init()
        self.view = view
    }
    func setupTableView(){
        view?.tableView.dataSource = self
        view?.tableView.delegate = self
        view?.tableView.register(ImageTVC.nib(), forCellReuseIdentifier: ImageTVC.indentifier)
        view?.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
extension HomeUIVC: UITableViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > ((view?.tableView.contentSize.height)!-200-scrollView.frame.size.height){
            
            guard !RestManger.shared.isPaginating else {return}
            
            RestManger.shared.fetchData(pagination:true, from: "https://picsum.photos/v2/list?page=\(Int.random(in: 0...10))&limit=10", method: "GET") { [weak self] out in
                    switch out{
                    case .success(let moreData):
                        self?.view?.fetched?.append(contentsOf: moreData)
                        DispatchQueue.main.async {
                            self?.view?.tableView.reloadData()
                        }
                    case .failure(_):
                        break
                    }
                }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "DetailsVC", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailsVC") as? DetailsVC else {return}
        
        vc.id = view?.fetched?[indexPath.row].id
        
        vc.title = "Details"
        vc.navigationItem.largeTitleDisplayMode = .never
        view?.navigationController?.pushViewController(vc, animated: true)
    }
}
extension HomeUIVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return view?.fetched?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageTVC.indentifier) as? ImageTVC else {return UITableViewCell()}
        
        cell.author.text = self.view?.fetched?[indexPath.row].author
        cell.downloadImage(url: self.view?.fetched?[indexPath.row].downloadURL ?? "")
    
        return cell
    }
}
