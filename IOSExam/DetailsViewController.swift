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
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "Dashboard") as! DashboardViewController
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rewardsLabel.text = rewards
        descriptionLabel.text = desc
    }
}
