//
//  HATextField.swift
//
//  Copyright © 2017 . All rights reserved.
//

import UIKit

protocol toolBarDelegate {
    func leftBarButtonTapped(sender: UIButton)
    func rightBarButtonTapped(sender: UIButton)
}

class HATextField: UITextField {
    
    var delegateVar: toolBarDelegate?
    var borderlayer: CALayer?
    var errorLabel: UILabel?
    fileprivate var errorTextColor: UIColor = UIColor(red: 234.0/255.0, green: 79.0/255.0, blue: 79.0/255.0, alpha: 0.3)

    @IBInspectable var textFieldTextColor: UIColor?
    @IBInspectable var fieldBorderColor: UIColor?
    @IBInspectable var borderHeight:CGFloat = 1 {
        didSet {
            borderlayer?.borderWidth = self.borderHeight

        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func draw(_ rect: CGRect) {

        if borderlayer == nil {
            borderlayer = CALayer()
            let  borderWidth:CGFloat = borderHeight
            borderlayer?.borderColor = fieldBorderColor?.cgColor
            borderlayer?.frame = CGRect(x: 0, y: self.frame.size.height-borderWidth, width: self.frame.size.width, height: self.frame.size.height)
            borderlayer?.borderWidth = borderWidth
            self.layer.addSublayer(borderlayer!)
            self.layer.masksToBounds = true
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 15, y: bounds.origin.y - 5, width: bounds.width, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 15, y: bounds.origin.y - 5, width: bounds.width, height: bounds.height)
    }
    
    func showErrorLabel(errorMsg:String) {
        
        self.checkAndCreateErrorLabel()
        self.showBorderLineAsError()
        errorLabel?.text = errorMsg
        UIView.animate(withDuration: 0.15) {
            self.errorLabel?.alpha = 1.0
        }
        
    }
    
    func showBorderLineAsError() {
        borderlayer?.borderColor = UIColor.init(red: 0.905, green: 0.302, blue: 0.282, alpha: 1).cgColor
    }
    
    func hideErrorLabel() {
        borderlayer?.borderColor = UIColor.init(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1).cgColor
        UIView.animate(withDuration: 0.15) {
            self.errorLabel?.alpha = 0.0
        }
    }
    
    func checkAndCreateErrorLabel() {
        if errorLabel == nil {
            errorLabel = UILabel.init(frame: CGRect(x: self.frame.origin.x+15, y: self.frame.origin.y+self.frame.size.height+6, width: self.frame.size.width, height: 12))
            errorLabel?.backgroundColor = .clear
            errorLabel?.textColor = errorTextColor
            errorLabel?.text = ""
            errorLabel?.font = UIFont(name: "Nexa Bold", size: 12)
            self.superview?.addSubview(errorLabel!)
            
        }
    }
    
    func setHidden(shouldHide:Bool) {
        super.isHidden = shouldHide
        self.hideErrorLabel()
    }
    
    func addToolBarAboveKeyboard(leftButtonTitle: String, rightButtonTitle: String) {
        
        let numberToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 50))
        numberToolbar.barStyle = .default
        
        let doneButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        doneButton.contentHorizontalAlignment = .left
        doneButton.contentVerticalAlignment = .fill
        doneButton.setTitle(leftButtonTitle, for: .normal)
        doneButton.setTitleColor(UIColor.black, for: .normal)
        doneButton.addTarget(self, action: #selector(leftBarButtonTapped(sender:)), for: .touchUpInside)
        
        let doneBarButton = UIBarButtonItem(customView: doneButton)
        
        let cancelButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        cancelButton.contentHorizontalAlignment = .right
        cancelButton.contentVerticalAlignment = .fill
        cancelButton.setTitle(rightButtonTitle, for: .normal)
        cancelButton.titleLabel?.textColor = UIColor.black
        cancelButton.setTitleColor(UIColor.black, for: .normal)
        cancelButton.addTarget(self, action: #selector(rightBarButtonTapped(sender:)), for: .touchUpInside)
        
        let cancelBarButton = UIBarButtonItem(customView: cancelButton)
        
        numberToolbar.items = [doneBarButton, UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), cancelBarButton]
        numberToolbar.sizeToFit()
        inputAccessoryView = numberToolbar
        
        
    }
    
    override func becomeFirstResponder() -> Bool {
        self.textColor = textFieldTextColor
        if self.text?.count == 0 {
            
        }
        self.hideErrorLabel()
        return super.becomeFirstResponder()
        
    }
    
    override func resignFirstResponder() -> Bool {
        return super.resignFirstResponder()
    }
    
    @objc func leftBarButtonTapped(sender: UIButton) {
        delegateVar?.leftBarButtonTapped(sender: sender)
    }
    
    @objc func rightBarButtonTapped(sender: UIButton) {
        delegateVar?.rightBarButtonTapped(sender: sender)
            
    }
    
}
