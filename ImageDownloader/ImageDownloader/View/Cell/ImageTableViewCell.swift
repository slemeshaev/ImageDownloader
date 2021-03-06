//
//  ImageTableViewCell.swift
//  ImageDownloader
//
//  Created by Станислав Лемешаев on 05.03.2021.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var photoView: UIImageView!
    
    var unsplashPhoto: UnsplashPhoto! {
        didSet {
            let imageUrl = unsplashPhoto.urls["regular"]
            guard let url = imageUrl else { return }
            photoView.loadImage(with: url)
        }
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoView.image = nil
    }
    
    // MARK: - Helpers
    
//    func downloadImage(withURL url: URL, forCell cell: UITableViewCell) {
//        //
//    }
    
//    func configure(logo: UIImage, city: String) {
//        self.photoView.image = logo
//    }
//

}
