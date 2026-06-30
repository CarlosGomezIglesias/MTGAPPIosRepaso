//
//  ProductViewCell.swift
//  MTGAPPIosRepaso
//
//  Created by Tardes on 30/6/26.
//

import UIKit

class ProductViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with product: Product) {
        self.nameLabel.text = product.title
        self.thumbnailImageView.image = nil
        self.thumbnailImageView.loadFrom(url: product.thumbnail)
        self.categoryLabel.text = product.category.capitalized
        self.priceLabel.text = "\(product.price)€"
        
    }

}
