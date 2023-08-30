//
//  DashboardTableViewController.swift
//  IOSExam
//
//  Created by Criselda Aguilar on 8/28/23.
//

import UIKit

class DashboardTableViewController: UITableViewController {
    
    @IBOutlet var dashboardTable: UITableView!
    
    enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dashboardTable.separatorStyle = .none
        
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        dashboardTable.register(nib, forCellReuseIdentifier: "CustomCell")
        
        configureDataSource()
        dashboardTable.delegate = self
        dashboardTable.dataSource = dataSource
        
        applySnapshot()
    }
    
    var dataSource: UITableViewDiffableDataSource<Section, DataModel>!
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, DataModel>(
            tableView: tableView,
            cellProvider: { tableView, indexPath, item in
                // Dequeue the custom cell
                let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
                // string url for the image
                cell.imageUrl = item.image
                cell.descriptionLabel.text = item.description
                return cell
            }
        )
    }

    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DataModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems([
            DataModel(id: 1,
                      name: "Shopee 100Php Off",
                      description: "100Php off on Shopee with a minimum purchase of 1000Php!",
                      image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjAk8-sic9MUEOpyMJXpnQkbLz2wUMOmUvYep80A8FRbH3bVeb&s"),
            DataModel(id: 2,
                      name: "Zalora Free Delivery",
                      description: "Free delivery on any order from Zalora.",
                      image: "https://static-sg.zacdn.com/cms/zaloranow/ZNOW_FA_LOGOS_PRIMARY_BLACK.png"),
            DataModel(id: 3,
                      name: "Mang Inasal",
                      description: "Free Extra Rice",
                      image: "https://www.rappler.com/tachyon/r3-assets/612F469A6EA84F6BAE882D2B94A4B421/img/48C62896A45B47CAADB8124477BDB9D3/mang-inasal-20200331.jpg")], toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "Details") as! DetailsViewController
        view.modalPresentationStyle = .fullScreen
        
        let selectedRow = indexPath.row
        let selectedData = dataSource.itemIdentifier(for: indexPath)
 
            // Set the properties with the selected data
        view.desc = selectedData?.description ?? ""
        view.image = selectedData?.image ?? ""
        view.rewards = selectedData?.name ?? ""
        self.present(view, animated: false)
    }
}
