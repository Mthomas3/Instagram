//
//  MyStoryView.swift
//  Instagram
//
//  Created by Thomas on 21/07/2021.
//

import UIKit

class MyStoryView: UIView {
    
    @IBOutlet private weak var bigCircleView: UIView!{
        didSet {
            self.bigCircleView.clipsToBounds = true
            self.bigCircleView.layer.masksToBounds = true
            self.bigCircleView.layer.cornerRadius = self.bigCircleView.frame.width / 2
            self.bigCircleView.layer.borderColor = UIColor.init(named: "Gray")?.cgColor
            self.bigCircleView.layer.borderWidth = 1
        }
    }
    
    @IBOutlet private weak var smallCircleView: UIView! {
        didSet {
            self.smallCircleView.clipsToBounds = true
            self.smallCircleView.layer.masksToBounds = true
            self.smallCircleView.layer.cornerRadius = self.smallCircleView.frame.width / 2
            self.smallCircleView.layer.borderWidth = 0
        }
    }
    
    internal var delegate: EventStory?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    internal func setup() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapTriggerEvent))
        self.addGestureRecognizer(tap)
    }
    
    @objc private func tapTriggerEvent() {
        self.delegate?.myStoryTapped()
    }
    
}
