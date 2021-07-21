//
//  ViewController.swift
//  Instagram
//
//  Created by Thomas on 21/07/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var dataSources: [MainTableViewProtocol] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerTableView()
        self.loadData()
    }
    
    private func registerTableView() {
        self.tableView.register(FeedTableViewCell.nib, forCellReuseIdentifier: FeedTableViewCell.identifier)
        self.tableView.register(StoryTableViewCell.nib, forCellReuseIdentifier: StoryTableViewCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func formatDataTableView(with users: Users) -> [MainTableViewProtocol] {
        let stories: [StoryCell] = [.init(with: users)]
        let news: [NewsCell] = [.init(), .init(), .init(), .init(), .init()]
        
        return stories + news
    }

    private func loadData() {
        UserService.getUsers { (result: Result<Users, APIServiceError>) in
            switch result {
            case .success(let users):
                
                self.dataSources = self.formatDataTableView(with: users)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.dataSources[indexPath.row].type == .Story {
            if let cell = tableView.dequeueReusableCell(withIdentifier: StoryTableViewCell.identifier, for: indexPath) as? StoryTableViewCell {
                if let item = self.dataSources[indexPath.row] as? StoryCell {
                    cell.delegate = self
                    cell.setup(with: item.user.users + item.user.users)
                }
                return cell
            }
        } else if self.dataSources[indexPath.row].type == .News {
            if let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as? FeedTableViewCell {
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.dataSources[indexPath.row].type == .News {
            return 501.0
        }
        return 100.0
    }
    
}

extension ViewController: EventStory {
    
    func myStoryTapped() {
        if let vc = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "StoryViewController") as? StoryViewController {
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            vc.setup(with: nil)
            self.present(vc, animated: true)
        }
    }
    
    func someStoryTapped(with data: User) {
        if let vc = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "StoryViewController") as? StoryViewController {
            vc.setup(with: data)
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true)
        }
    }

}
