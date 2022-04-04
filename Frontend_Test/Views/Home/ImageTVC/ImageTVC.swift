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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    override func prepareForReuse() {
//        author.text = ""
//        images.image = UIImage(systemName: "photo.artframe")
//    }
    
}
