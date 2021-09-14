//
//  TableViewCell.swift
//  Burner iOS App
//
//  Created by Ayush Singh on 13/09/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameMovieText: UILabel!
    @IBOutlet weak var typeMovieText: UILabel!
    @IBOutlet weak var yearMovieText: UILabel!
    @IBOutlet weak var imageMovieText: UIImageView!

    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
    }

}
