//
//  UIImageView.swift
//  ImageDownloader
//
//  Created by Станислав Лемешаев on 05.03.2021.
//

import UIKit

var imageCache = [String: UIImage]()

extension UIImageView {
    // метод загрузки изображения
    func loadImage(with urlString: String) {
        // проверка на существование изображения в кэше
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }
        
        // ссылка на расположение изображения
        guard let url = URL(string: urlString) else { return }
        
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
            imageCache[url.absoluteString] = photoImage
            
            // установка изображения
            DispatchQueue.main.async {
                self.image = photoImage
            }
        }.resume()
        
    }
}
