//
//  FilterViewController.swift
//  iOS-assignment
//
//  Created by Mariam Abdulkareem  on 13/12/2021.
//

import UIKit

class FilterVehicleViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    var delegate: FleetFilteringProtocol?
    
    
    @IBOutlet weak var redGreenSwitch: DottSwitch!
    @IBOutlet weak var blueRedSwitch: DottSwitch!
    @IBOutlet weak var pinkYellowSwitch: DottSwitch!
    @IBOutlet weak var yellowBlueSwitch: DottSwitch!
    @IBOutlet weak var closeButton: CloseButton!
    @IBOutlet weak var applyFilterButton: PrimaryButton!
    
    var viewModel: FilterVehicleViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        viewModel?.getSwitchState()
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func applyFilterButtonTapped(_ sender: UIButton) {
        let updatedSwitchArray = [ redGreenSwitch.isOn, blueRedSwitch.isOn, pinkYellowSwitch.isOn, yellowBlueSwitch.isOn]
        viewModel?.updateSwitchState(updatedSwitchArray: updatedSwitchArray)
        delegate?.filterVehicleListWithSwitchState()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    private func bind(to viewModel: FilterVehicleViewModelProtocol?) {
        viewModel?.retrieveSwitchStates.observe(on: self) { [weak self] value in
            guard let value = value, let self = self else {return}
            self.redGreenSwitch.isOn = value[0]
            self.blueRedSwitch.isOn = value[1]
            self.pinkYellowSwitch.isOn = value[2]
            self.yellowBlueSwitch.isOn = value[3]
            
        }
    }
    
    
}
