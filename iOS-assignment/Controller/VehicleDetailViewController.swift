//
//  VehicleDetailViewController.swift
//  iOS-assignment
//
//  Created by Mariam Abdulkareem  on 14/12/2021.
//

import Foundation
import UIKit

class VehicleDetailViewController: UIViewController {
    
    var identificationCodeString: String?
    var qrCodeImageURL: String?
    
    @IBOutlet weak var identificationCodeLabel: TitleLabel!
    @IBOutlet weak var qrCodeImage: DottImageView!
    @IBOutlet weak var closeButton: CloseButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        identificationCodeLabel.text = identificationCodeString
        qrCodeImage?.downloaded(from: qrCodeImageURL ?? "")
    }
    
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}



