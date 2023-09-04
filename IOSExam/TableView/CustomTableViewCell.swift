//
//  CustomTableViewCell.swift
//  IOSExam
//
//  Created by Criselda Aguilar on 8/28/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var rewardsImage: UIImageView!
    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var cellStackView: UIStackView!
    
    var imageUrl: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cellStackView.layer.cornerRadius = 10
        cellStackView.layer.masksToBounds = true
        
        cellContentView.layer.shadowColor = UIColor.black.cgColor
        cellContentView.layer.shadowOpacity = 0.5
        cellContentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cellContentView.layer.shadowRadius = 4
    }
    
    func configure(with item: DataModel) {
        // customer methods if needed
    }
}
