//
//  TableViewProtocol.swift
//  Instagram
//
//  Created by Thomas on 21/07/2021.
//

import Foundation

internal enum MainTypeCell {
    case News
    case Story
}

internal protocol MainTableViewProtocol {
    var type: MainTypeCell { get }
}

internal struct NewsCell: MainTableViewProtocol {
    var type: MainTypeCell {
        return .News
    }
}

internal struct StoryCell: MainTableViewProtocol {
    let user: Users
    
    var type: MainTypeCell {
        return .Story
    }
    
    init(with users: Users) {
        self.user = users
    }
}

internal protocol EventStory {
    func myStoryTapped()
    func someStoryTapped(with data: User)
}
