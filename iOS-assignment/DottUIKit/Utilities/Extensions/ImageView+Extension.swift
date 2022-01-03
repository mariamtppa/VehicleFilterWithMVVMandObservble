//
//  ImageView+Extension.swift
//  iOS-assignment
//
//  Created by Mariam Abdulkareem  on 14/12/2021.
//

import Foundation
import UIKit


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
//        fetches images and displays image using url gotten from the api
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                                let data = data, error == nil,
                                let image = UIImage(data: data)
                                else { return }
                            DispatchQueue.main.async() { [weak self] in
                                self?.image = image
                            }
                        }.resume()
                    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
            guard let url = URL(string: link) else { return }
            downloaded(from: url, contentMode: mode)
        }
}
