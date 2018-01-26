//
//  SearchResultTableViewCell.swift
//  SearchApp
//
//  Created by Vladislav on 1/25/18.
//  Copyright © 2018 Vladislav. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
   
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var resultLinkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
