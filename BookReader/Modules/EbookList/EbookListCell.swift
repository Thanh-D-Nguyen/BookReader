//
//  EbookListCell.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/09.
//

import UIKit

class EbookListCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateBook(_ book: Book) {
        nameLabel.text = book.title
    }
}
