//
//  MediumCell.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/09.
//

import UIKit

class MediumCell: UITableViewCell {
    
    @IBOutlet private weak var mTitleLabel: UILabel!
    @IBOutlet private weak var mImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateMedium(_ medium: Medium) {
        mTitleLabel.text = medium.name
        mImageView.image = UIImage(named: medium.image)
    }
}
