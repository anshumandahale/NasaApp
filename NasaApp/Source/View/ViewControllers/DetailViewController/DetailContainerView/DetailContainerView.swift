//
//  DetailContainerView.swift
//  NasaApp
//
//  Created by Anshuman Dahale on 22/10/22.
//

import UIKit
import SDWebImage
import SwiftInfiniteScrollView

class DetailContainerView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func setupWithImage(image: NasaImage) {
        self.titleLabel.text = image.title
        self.descriptionLabel.text = image.explanation
        guard let url = URL(string: image.hdurl) else { return }
        self.imageView.sd_setImage(with: url, placeholderImage: nil)
    }
}
