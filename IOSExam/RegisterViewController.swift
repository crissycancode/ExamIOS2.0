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
        self.dismiss(animated: true)
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        
//        test data only
//        testData()
        
        let alltextFieldsAreFilled = allTextFieldsAreFilled()
        guard alltextFieldsAreFilled else {
            // alert user of the empty field or high light the empty fields in red
            showAlert("required fields", message: "some fields are empty")
            print ("‼️ some fields are empty")
            return
        }
        
        let mobileNumberIsRegistered = CoreDataStack().doesMobileNumberExistInCoreData(mobileNumberTextField.text!)
        guard !mobileNumberIsRegistered else {
            // alert user that the number is already used/registered
            showAlert("mobile number", message: "already registered")
            print ("‼️ number is already registered")
            return
        }
        
        let mpinFieldsMatchIsConfirmed = confirmMpinMatchInvalue()
        guard mpinFieldsMatchIsConfirmed else {
            // alert user that the mpin should match
            showAlert("mpin", message: "does not match")
            print ("‼️ mprin does not match")
            return
        }
        
        let user = NewUser.init(first_name: firstNameTextField.text!,
                                last_name: lastNameTextField.text!,
                                mobile: mobileNumberTextField.text!,
                                mpin: mpinTextField.text!,
                                id: UUID(),
                                is_verified: true,
                                referral_code: generateReferralCode())
        
        CoreDataStack().insertUserInputToCoreDataAndJson(user)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "DashboardNavigationController") as! UINavigationController
        view.modalPresentationStyle = .fullScreen
        let dashboard = view.viewControllers.first as! DashboardViewController
        dashboard.mobileNumber = mobileNumberTextField.text!
        self.present(view, animated: false)
    }
    
    private func confirmMpinMatchInvalue() -> Bool{
        return mpinTextField.text == confirmMpinTextField.text
    }
    
    private func allTextFieldsAreFilled() -> Bool{
        return firstNameTextField.text != "" &&
        lastNameTextField.text != "" &&
        mobileNumberTextField.text != "" &&
        mpinTextField.text != "" &&
        confirmMpinTextField.text != ""
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
    
    private func testData() {
        firstNameTextField.text = "peppa"
        lastNameTextField.text = "pig"
        mobileNumberTextField.text = "9123456347"
        mpinTextField.text = "george"
        confirmMpinTextField.text = "george"
    }
    
    private func generateReferralCode() -> String {
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let length = 8
        let referralCode = String((0..<length).map { _ in allowedChars.randomElement()! })
        return referralCode
    }
    
    func showAlert(_ alertTitle: String, message alertMessage: String) {
        let alertController = UIAlertController(title: alertTitle, message:alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            print("OK tapped")
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
