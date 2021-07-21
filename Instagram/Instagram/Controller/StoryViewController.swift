//
//  StoryViewController.swift
//  Instagram
//
//  Created by Thomas on 21/07/2021.
//

import UIKit

class StoryViewController: UIViewController {

    @IBOutlet private weak var labelName: UILabel!
    @IBOutlet private weak var profilePicture: UIImageView! {
        didSet {
            self.profilePicture.layer.cornerRadius = self.profilePicture.frame.height / 2
            self.profilePicture.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet private weak var middleImage: UIImageView!
    
    private var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = user {
            self.download(with: data.pictureURL) { result in
                self.profilePicture.image = result
            }
            
            if let firstStory = data.stories.first {
                self.download(with: firstStory.imageURL ?? "") { result in
                    self.middleImage.image = result
                }
            }
            
            
        }
    }
    
    private func download(with url: String, completion: @escaping (UIImage) -> ()) {
        guard let url = URL(string: url) else { return }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    completion(UIImage(data: data) ?? UIImage())
                }
            }
        }
    }

    @IBAction func closeEvent(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    internal func setup(with user: User?) {
        self.user = user
    }
    
}
