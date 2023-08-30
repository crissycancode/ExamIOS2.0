//
//  ViewController.swift
//  IOSExam
//
//  Created by Criselda Aguilar on 8/27/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: false)
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "Register") as! RegisterViewController
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: false)
    }
}

