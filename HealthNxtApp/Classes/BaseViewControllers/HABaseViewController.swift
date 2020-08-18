//
//  HABaseViewController.swift
//  HealthAdvisor
//
//  Created by Satyanand T on 23/10/17.
//  Copyright © 2017 KaaraInfoSystems. All rights reserved.
//

import UIKit

class HABaseViewController: UIViewController {
    
    var titlelabel: UILabel!
    var tapToRefeshButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: UIBarButtonItem.Style.done, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.haNavigationBlueColor()
        let leftBarButton: UIButton = UIButton.init(type: .custom)
        leftBarButton.frame = CGRect(x: 0, y: 7, width: 30, height: 30)
        leftBarButton.setImage(UIImage.init(named: "backarrow"), for: .normal)
        leftBarButton.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
        leftBarButton.imageEdgeInsets = UIEdgeInsets(top: -5,left: -15, bottom: 0, right: 0)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        titlelabel = UILabel.init(frame: CGRect(x: 0, y: 10, width: 200, height: 20))
        titlelabel.textColor = UIColor.white
        titlelabel.textAlignment = NSTextAlignment.left
        titlelabel.font = UIFont.init(name: "Nexa Regular", size: 16.0)
        
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem.init(customView: leftBarButton),UIBarButtonItem.init(customView: titlelabel)]
        
        tapToRefeshButton = UIButton(type: UIButton.ButtonType.custom)
        tapToRefeshButton.frame = CGRect(x: 0, y: 0, width: HAConstants.HA_APPLICATION_SCREEN_WIDTH, height: 60)
        tapToRefeshButton.setTitle(NSLocalizedString("HA_NO_RECORDS_TEXT", comment: "") , for: UIControl.State.normal)
        tapToRefeshButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        tapToRefeshButton.contentVerticalAlignment = .fill
        tapToRefeshButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        tapToRefeshButton.titleLabel?.textAlignment = NSTextAlignment.center
        tapToRefeshButton.titleLabel!.font =  UIFont(name: "Nexa Regular", size: 15)
        
        //tapToRefeshButton.titleLabel.font = [BNSUtilities getAppRegularFontWithSize:12.0f];
        tapToRefeshButton .addTarget(self, action: #selector(refreshDataContent), for: UIControl.Event.touchUpInside)
        self.view.addSubview(tapToRefeshButton)
        tapToRefeshButton.center = self.view.center
        tapToRefeshButton.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    // MARK: - Instance methods
    func addMenuButtonToLeftBarButton()  {
        
        let menuImage = UIImage(named: "left_menu")!.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: menuImage, style: UIBarButtonItem.Style.plain, target: self, action: #selector(showSideMenu))
        self.navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: -11, bottom: 0, right: 0)
    }
    
    @objc func popViewController()  {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func refreshDataContent() {
        
        print("refreshDataContent in baseviewcontroller")
    }
    
    // MARK: - checking network connectivity
    func isConnected() -> Bool {
        
        if CommonUtilities.isInternetConnectionAvailable() {
            return true
            
        } else {
            
           
            return false
        }
    }
    
    // MARK: - activity indicator show and hide methods
    func showLoadingIndicator() {
        
        
    }
    
    func hideLoadingIndicator() {
        
        
    }
    
    // MARK: - present the side menu on current controller
    @objc func showSideMenu()  {
        
        self.closeKeyboard()
    }
    
    // MARK: - keyboard handling
    func closeKeyboard()  {
        
        self.view.endEditing(true)
    }
    
    // MARK: - handling error related messages
   
    
    
    func hideNoRecordsMessage() {
        
        tapToRefeshButton.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
