//
//  UIImageViewExtension.swift
//  FreeToGame-IOS
//
//  Created by Tardes on 28/5/26.
//

import UIKit

extension UIImageView{
    func loadFrom(url: URL){
        DispatchQueue.global(qos: .background).async {[weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                }
                
                }
            }
        }
    }
    func loadFrom(url: String){
        if let url = URL(string: url) {
            self.loadFrom(url: url)
        }
        
    
    }
}
