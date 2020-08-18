//
//  HAButton.swift
//  HealthAdvisor
//
//  Created by Satyanand T .
//  Copyright © 2017 . All rights reserved.
//

import UIKit

class HAButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
      self.layer.cornerRadius = self.frame.size.height/2
      self.backgroundColor = UIColor.haButtonBlueColor()
        
    }
    
    
}
