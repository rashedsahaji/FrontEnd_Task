//
//  ImageTVC.swift
//  Frontend_Test
//
//  Created by Big oh on 02/04/22.
//

import UIKit

class ImageTVC: UITableViewCell {
    
    static let indentifier = "ImageTVC"
    static func nib() -> UINib {
        return UINib(nibName: indentifier, bundle: nil)
    }
    
    @IBOutlet weak var author:UILabel!
    @IBOutlet weak var images: UIImageView!
//    var fetchedImages:MyResultElement?
    
    var session = URLSession.shared
    var task = URLSessionDownloadTask()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        author.text = ""
        if #available(iOS 13.0, *) {
            images.image = UIImage(systemName: "photo.artframe")
        } else {
            // Fallback on earlier versions
        }
    }
    
    func downloadImage(url: String){
        let url:URL! = URL(string: url)
                task = session.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
                    if let data = try? Data(contentsOf: url){
                        DispatchQueue.main.async(execute: { () -> Void in
                            let img:UIImage! = UIImage(data: data)
                            self.images?.image = img
                        })
                    }
                })
                task.resume()
    }
}
