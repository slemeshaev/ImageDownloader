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
            guard let urlString = imageUrl else { return }
            guard let url = URL(string: urlString) else { return }
            downloadImage(withURL: url, forCell: ImageTableViewCell())
        }
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoView.image = nil
    }
    
    // MARK: - Helpers
    
    private func downloadImage(withURL url: URL, forCell cell: UITableViewCell) {
        var imageCache = [URL: UIImage]()
        
        // проверка на существование изображения в кэше
        if let cachedImage = imageCache[url] {
            photoView.image = cachedImage
            return
        }
        
        // извлечь содержимое ссылки
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // обработка ошибок
            if let error = error {
                print("Ошибка загрузки изображения с ошибкой \(error.localizedDescription)")
            }
            
            // данные изображения
            guard let imageData = data else { return }
            
            // установка изображения, используя данные
            let photoImage = UIImage(data: imageData)
            
            // установка ключа и значения для изображения в кэше
            imageCache[url] = photoImage
            
            // установка изображения
            DispatchQueue.main.async {
                self.photoView.image = photoImage
            }
        }.resume()
    }
    

}
