//
//  RegisterViewController.swift
//  IOSExam
//
//  Created by Criselda Aguilar on 8/28/23.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var firstNameTextField: CustomTextField!
    @IBOutlet weak var lastNameTextField: CustomTextField!
    @IBOutlet weak var mobileNumberTextField: CustomTextField!
    @IBOutlet weak var mpinTextField: CustomTextField!
    @IBOutlet weak var confirmMpinTextField: CustomTextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func backButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "Main") as! ViewController
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: false)
    }
    @IBAction func registerButtonAction(_ sender: Any) {
        if mpinTextField.text == confirmMpinTextField.text {
            // TODO: go to next screen
        } else {
            // TODO: prompt about the mpin should match
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstNameTextField.placeholder = "Enter First Name"
        lastNameTextField.placeholder = "Enter Last Name"
        mobileNumberTextField.placeholder = "Enter Mobile Number"
        mpinTextField.placeholder = "Enter MPIN"
        confirmMpinTextField.placeholder = "Confirm MPIN"
        
        mpinTextField.isSecureTextEntry = true
        confirmMpinTextField.isSecureTextEntry = true
        
        mobileNumberTextField.isNumbersOnly = true
    }
}
