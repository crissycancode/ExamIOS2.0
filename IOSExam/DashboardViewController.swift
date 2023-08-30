//
//  DashboardViewController.swift
//  IOSExam
//
//  Created by Criselda Aguilar on 8/28/23.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var referralCodeLabel: UILabel!
    
    private var firstName: String = "Mang"
    private var lastName: String = "Tani"
    private var mobileNumber: String = "9123456789"
    private var referralCode: String = "qwe123"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = "\(firstName) \(lastName)"
        mobileLabel.text = mobileNumber
        referralCodeLabel.text = referralCode
    }
}
