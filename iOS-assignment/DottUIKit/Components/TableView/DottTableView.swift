//
//  DottTableView.swift
//  iOS-assignment
//

import UIKit
import RxCocoa
import AssignmentUtility

class DottTableView: UITableView {
    
    // MARK: - Lifecycle
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        commonInit()
    }
    
    func commonInit() {
        setupUI()
    }
    
    func setupUI() {
        
    }

}
