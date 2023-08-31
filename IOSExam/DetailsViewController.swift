//
//  DetailsViewController.swift
//  IOSExam
//
//  Created by Criselda Aguilar on 8/29/23.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var desc: String = ""
    var rewards: String = ""
    var image: String = ""
    
    @IBOutlet weak var rewardsImage: UIImageView!
    @IBOutlet weak var rewardsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var backBarButton: UIBarButtonItem!
    
    @IBAction func backBarButtonAction(_ sender: Any) {
////        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: <#T##String#>)
//        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
//        let viewController = storyboard.instantiateViewController(withIdentifier: "Dashboard") as! DashboardViewController
//        viewController.modalPresentationStyle = .fullScreen
//        self.present(viewController, animated: false)
        
//        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rewardsLabel.text = rewards
        descriptionLabel.text = desc
        
        readJsonFile()
    }
    
    struct Reward: Codable {
        let id: Int
        let name: String
        let description: String
        let image: String
    }
    
    func readJsonFile() {
        guard let url = Bundle.main.url(forResource: "Rewards", withExtension: "JSON"),
              let jsonData = try? Data(contentsOf: url) else {
            fatalError("Failed to load JSON data")
        }
        
        let decoder = JSONDecoder()

        do {
            let rewards = try decoder.decode([Reward].self, from: jsonData)
            
            // Now, 'rewards' contains an array of Reward objects.
            for reward in rewards {
                print("Reward ID: \(reward.id)")
                print("Name: \(reward.name)")
                print("Description: \(reward.description)")
                print("Image URL: \(reward.image)")
            }
        } catch {
            print("JSON decoding error: \(error.localizedDescription)")
        }
    }
}
