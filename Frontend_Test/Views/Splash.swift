//
//  Splash.swift
//  Frontend_Test
//
//  Created by Big oh on 02/04/22.
//

import UIKit

class Splash: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadScreen()
    }
    func loadScreen(){
        let vc = HomeVC.`init`()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overFullScreen
        AppDelegate.shared().window?.rootViewController = nav
        AppDelegate.shared().window?.makeKeyAndVisible()
    }

}
