//
//  ProductListCell.swift
//  ConfirmedHomeAssignment
//
//  Created by Igor Vedeneev on 15.09.2021.
//

import UIKit
import SDWebImage

final class ProductListCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let priceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        backgroundColor = UIColor(named: "ProductListBG")
        
        let labelsStack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, priceLabel])
        labelsStack.axis = .vertical
        labelsStack.spacing = 8
        
        addSubview(imageView)
        addSubview(labelsStack)
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        labelsStack.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont.listTitle
        priceLabel.font = UIFont.listPrice
        descriptionLabel.font = UIFont.body
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            labelsStack.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            labelsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            labelsStack.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 16),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.sd_cancelCurrentImageLoad()
    }
}

extension ProductListCell: ReusableCell {
    
    func configure(viewModel: Product) {
        imageView.sd_setImage(with: URL(string: viewModel.imgUrl))
        titleLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        priceLabel.text = viewModel.formattedPrice
    }
}

