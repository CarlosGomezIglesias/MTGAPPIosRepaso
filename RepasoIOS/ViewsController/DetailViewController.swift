//
//  DetailViewController.swift
//  MTGAPPIosRepaso
//
//  Created by Tardes on 30/6/26.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var product: Product!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = product.title
        
        Task {
            product = await ApiService.getProductById(product.id)
            
            DispatchQueue.main.async {
                self.loadData()
            }
        }
        
    }
    func loadData(){
        thumbnailImageView.loadFrom(url:  product.thumbnail)
        nameLabel.text = product.title
        priceLabel.text = "\(product.price)€"
        descriptionLabel.text = product.description
        discountLabel.text = "-\(product.discountPercentage)%"
        ratingLabel.text = "\(product.rating)⭐️"
        categoryLabel.text = product.category.capitalized
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
