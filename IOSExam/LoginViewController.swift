//
//  LoginViewController.swift
//  IOSExam
//
//  Created by Criselda Aguilar on 8/27/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var mobileNumberTextField: CustomTextField!
    @IBOutlet weak var mpinTextField: CustomTextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        
        let login = mobileNumberTextField.text ?? ""
        let password = mpinTextField.text ?? ""
        
        let canLogin = CoreDataStack().fetchLoginEntitiesFromCoreData(login: "9123456789", password: "1234")   // while developing only
        
//        let canLogin = CoreDataStack().fetchLoginEntitiesFromCoreData(login: login, password: password)
//
        guard canLogin == true else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "DashboardNavigationController") as! UINavigationController
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mobileNumberTextField.isNumbersOnly = true
        mobileNumberTextField.placeholder = "Enter Mobile Number"
        mpinTextField.placeholder = "Enter MPIN"
    }
}
