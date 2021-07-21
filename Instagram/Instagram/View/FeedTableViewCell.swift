//
//  FeedTableViewCell.swift
//  Instagram
//
//  Created by Thomas on 21/07/2021.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet private weak var circleView: UIView! {
        didSet {
            circleView.layer.cornerRadius = 15
        }
    }
    
    @IBOutlet private weak var topView: UIView! {
        didSet {
            topView.layer.cornerRadius = 7
        }
    }
    
    @IBOutlet private weak var middleView: UIView!
    
    @IBOutlet private weak var bottomView: UIView! {
        didSet {
            bottomView.layer.cornerRadius = 7
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    internal static var identifier: String {
        return String(describing: self)
    }
    
    internal static var nib: UINib {
        return UINib(nibName: self.identifier, bundle: .main)
    }
}
