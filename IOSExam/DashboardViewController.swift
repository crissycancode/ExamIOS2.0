//
//  DashboardViewController.swift
//  IOSExam
//
//  Created by Criselda Aguilar on 8/28/23.
//

import UIKit

class DashboardViewController: UIViewController {
    
    var mobileNumber: String = ""
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var referralCodeLabel: UILabel!
    
    
    private var firstName: String = ""
    private var lastName: String = ""
    private var referralCode: String = ""
    private var mobile: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        let user = CoreDataStack().fetchUserEntitiesFromCoreData(mobileNumber)
        
        firstName = user.first?.first_name ?? ""
        lastName = user.first?.last_name ?? ""
        mobile = user.first?.mobile ?? ""
        referralCode = user.first?.referral_code ?? ""

        nameLabel.text = "\(firstName) \(lastName)"
        mobileLabel.text = mobile
        referralCodeLabel.text = referralCode
        
    }
}
