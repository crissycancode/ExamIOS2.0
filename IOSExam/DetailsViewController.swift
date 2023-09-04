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

////        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: <#T##String#>)
//        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
//        let viewController = storyboard.instantiateViewController(withIdentifier: "Dashboard") as! DashboardViewController
//        viewController.modalPresentationStyle = .fullScreen
//        self.present(viewController, animated: false)
        
//        self.dismiss(animated: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rewardsLabel.text = rewards
        descriptionLabel.text = desc
    }
}
