//
//  CustomTextField.swift
//  IOSExam
//
//  Created by Criselda Aguilar on 8/28/23.
//
import UIKit

@IBDesignable
class CustomTextField: UITextField {
    
    private var isNumberOnly: Bool = false
    
    @IBInspectable var isNumbersOnly: Bool = false {
        didSet {
            isNumberOnly = isNumbersOnly
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0,
                                  y: self.frame.height + 2.0,
                                  width: self.frame.width,
                                  height: 1.5)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        self.borderStyle = .none
        self.layer.addSublayer(bottomLine)
        self.delegate = self
    }

}


extension CustomTextField: UITextFieldDelegate {
    
    /// Only accept numbers for the mobileNumberTextField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if isNumberOnly == true {
            let allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
            let replacementStringIsValid = string.rangeOfCharacter(from: allowedCharacterSet.inverted) == nil
            return replacementStringIsValid
        }
        
        return true
    }
    
    /// Remove placeholder text on first tap
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == textField.placeholder {
            textField.text = ""
        }
    }
    
    /// Dismiss keyboard when `return` is tapped
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
