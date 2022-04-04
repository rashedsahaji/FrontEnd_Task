//
//  DetailsUIVC.swift
//  Frontend_Test
//
//  Created by Big oh on 03/04/22.
//

import Foundation
protocol ObservableDetailsUIVC: AnyObject{
    var view:DetailsViewController? {get set}
    func setupDetails()
}
class DetailsUIVC:NSObject, ObservableDetailsUIVC{
    weak var view: DetailsViewController?
    
    init(view: DetailsViewController) {
        super.init()
        self.view = view
    }
    
    func setupDetails() {
        DispatchQueue.main.async {
            self.view?.author.text = self.view?.fetchedDetails?.author
        }
    }
}
