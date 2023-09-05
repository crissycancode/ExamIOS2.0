//
//  DashboardTableViewController.swift
//  IOSExam
//
//  Created by Criselda Aguilar on 8/28/23.
//

import UIKit

class DashboardTableViewController: UITableViewController {
    
    @IBOutlet var dashboardTable: UITableView!
    var dataSource: UITableViewDiffableDataSource<Section, RewardsDataModel>!
    enum Section { case main }
    var rewards: [RewardsEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rewards = fetchRewards()
        
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        dashboardTable.register(nib, forCellReuseIdentifier: "CustomCell")
        dashboardTable.separatorStyle = .none
        
        configureDataSource()
        dashboardTable.delegate = self
        dashboardTable.dataSource = dataSource
        applySnapshot()
    }
    
    /// Retrieves the rewards data
    /// - Returns: list of rewards in an array
    func fetchRewards() -> [RewardsEntity] {
        let coreDataStack = CoreDataStack()
        return coreDataStack.fetchRewards()
    }
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, RewardsDataModel>(
            tableView: tableView,
            cellProvider: { tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
                cell.imageUrl = item.image
                cell.descriptionLabel.text = item.description
                
                self.loadImageFromURL(urlString: item.image) { image in
                    if let image = image {
                        cell.rewardsImage.image = image
                    }
                }
                return cell
            }
        )
    }

    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, RewardsDataModel>()
        let rewardsDataModels = rewards.map { reward in
            RewardsDataModel(id: Int(reward.id), name: reward.name ?? "", description: reward.desc ?? "", image: reward.image ?? "")
        }
        snapshot.appendSections([.main])
        snapshot.appendItems(rewardsDataModels, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Details") as! DetailsViewController
        viewController.modalPresentationStyle = .fullScreen
        
        let selectedData = dataSource.itemIdentifier(for: indexPath)
        viewController.desc = selectedData?.description ?? ""
        viewController.rewards = selectedData?.name ?? ""
        
        self.loadImageFromURL(urlString: selectedData?.image ?? "") { image in
            if let image = image {
                viewController.rewardsImage.image = image
            }
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    func loadImageFromURL(urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }

            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
