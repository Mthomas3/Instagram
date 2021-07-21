//
//  StoryTableViewCell.swift
//  Instagram
//
//  Created by Thomas on 21/07/2021.
//

import UIKit

class StoryTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    private var dataSources: [UIView] = []
    
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
    
    internal var delegate: EventStory?
    
    private func generateView(with user: [User]) -> [UIView] {
        var stories: [UIView] = []
        
        if let myStory: MyStoryView = Bundle.main.loadNibNamed(MyStoryView.identifier, owner: nil, options: nil)?.first as? MyStoryView {
            myStory.setup()
            myStory.delegate = self
            stories.append(myStory)
        }
        
        user.forEach { user in
            if let story = Bundle.main.loadNibNamed(StoryView.identifier, owner: nil, options: nil)?.first as? StoryView {
                story.setup(with: user)
                story.delegate = self
                stories.append(story)
            }
        }
        
        return stories
    }
    
    internal func setup(with users: [User]) {
        self.scrollView.delegate = self
        self.dataSources = self.generateView(with: users)
        self.scrollView.reloadInputViews()
        self.setupScrollViewOnSlides()
    }

}

extension StoryTableViewCell: UIScrollViewDelegate {
    private func setupScrollViewOnSlides() {
        
        self.scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.containerView.frame.height)
        self.scrollView.contentSize = CGSize(width: 78 * CGFloat(self.dataSources.count), height: 0)
        self.scrollView.isPagingEnabled = true
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        for i in 0 ..< self.dataSources.count {
            self.dataSources[i].frame = CGRect(x: 78 * CGFloat(i), y: 0, width: 72, height: self.containerView.frame.height)
            self.scrollView.addSubview(self.dataSources[i])
        }
    }
}

extension StoryTableViewCell: EventStory {
    
    func myStoryTapped() {
        self.delegate?.myStoryTapped()
    }
    
    func someStoryTapped(with data: User) {
        self.delegate?.someStoryTapped(with: data)
    }
    
}
