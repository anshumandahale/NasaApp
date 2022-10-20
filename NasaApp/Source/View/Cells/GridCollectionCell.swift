//
//  GridCollectionCell.swift
//  NasaApp
//
//  Created by Anshuman Dahale on 16/10/22.
//

import UIKit
import SDWebImage

class GridCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureForImage(nasaImage: NasaImage) {
        let url = URL(string: nasaImage.url)
        self.imageView.sd_setImage(with: url)
        self.label.text = nasaImage.title
    }

}
