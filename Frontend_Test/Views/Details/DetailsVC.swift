//
//  DetailsVC.swift
//  Frontend_Test
//
//  Created by Big oh on 03/04/22.
//

import UIKit

protocol DetailsViewController: UIViewController{
    var imageHeight: UILabel!{get set}
    var author: UILabel!{get set}
    var image: UIImageView!{get set}
    var id:String?{get set}
    var fetchedDetails:ImageDetails?{get set}
}

class DetailsVC: UIViewController, DetailsViewController {
    var uiVC: ObservableDetailsUIVC!

    @IBOutlet weak var imageHeight: UILabel!
    @IBOutlet weak var imageWidth: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var id:String?
    var fetchedDetails:ImageDetails?
    
    private var imageCache = NSCache<AnyObject, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.global(qos: .background).async {
            FetchDetails.shared.fetchData(from: "https://picsum.photos/id/\(self.id ?? "")/info", method: "GET") { output in
                DispatchQueue.main.async {
                    self.fetchedDetails = output
                    self.setupDetails()
                }
            }
        }
    }
    
    func setupDetails(){
        self.author.text = self.fetchedDetails?.author
        self.imageHeight.text = "\(self.fetchedDetails?.height ?? 0)"
        self.imageWidth.text = "\(self.fetchedDetails?.width ?? 0)"
        
        guard let url = URL(string: fetchedDetails?.downloadURL ?? "") else {return}
        
        if let cacheImage = self.imageCache.object(forKey: url as AnyObject){
            self.image.image = cacheImage
        }
        
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self.imageCache.setObject(image, forKey: url as AnyObject)
                        self.image.image = image
                    }
                }
            }
        }
    }

    class func `init`() -> DetailsVC {
        let vc = UIStoryboard.details.instanceOf(viewController: DetailsVC.self)!
        vc.uiVC = DetailsUIVC(view: vc)
        return vc
    }

}
