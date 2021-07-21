//
//  StoryView.swift
//  Instagram
//
//  Created by Thomas on 21/07/2021.
//

import UIKit

class StoryView: UIView {

    @IBOutlet private weak var pictureStory: UIImageView! {
        didSet {
            self.pictureStory.layer.cornerRadius = self.pictureStory.frame.height / 2
            self.pictureStory.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet private weak var circleView: UIView! {
        didSet {
            self.circleView.clipsToBounds = true
            self.circleView.layer.masksToBounds = true
            self.circleView.layer.cornerRadius = self.circleView.frame.height / 2
            self.circleView.layer.borderColor = UIColor.init(named: "Blue")?.cgColor
            self.circleView.layer.borderWidth = 4
        }
    }
    
    internal var delegate: EventStory?
    private var userData: User?
    
    @IBOutlet private weak var nameLabel: UILabel!
    
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
    
    internal func setup(with user: User) {
        self.download(with: user.pictureURL)
        self.nameLabel.text = user.username
        self.userData = user
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapTriggerEvent))
        self.addGestureRecognizer(tap)
    }
    
    @objc private func tapTriggerEvent() {
        if let data = self.userData {
            self.delegate?.someStoryTapped(with: data)
        }
    }
    
    func download(with url: String) {
        guard let url = URL(string: url) else { return }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.pictureStory.image = UIImage(data: data)
                }
            }
        }
    }

}
