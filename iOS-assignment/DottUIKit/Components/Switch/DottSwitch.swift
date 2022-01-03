//
//  DottSwitch.swift
//  iOS-assignment
//

import UIKit

class DottSwitch: UISwitch {
    
    // MARK: - Lifecycle
    
    // this is the class that controls the switch(filter by color on or off)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        setupUI()
    }
    
    func setupUI() {
        
    }

}
