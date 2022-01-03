//
//  FleetViewController.swift
//  iOS-assignment
//
//  Created by Mariam Abdulkareem  on 13/12/2021.
//

import Foundation
import UIKit
import AssignmentUtility
import RxSwift
import RxRelay

protocol FleetFilteringProtocol {
    func filterVehicleListWithSwitchState()
}

class FleetViewController: UIViewController {

    var viewModel: FleetViewModelProtocol?
    
    @IBOutlet weak var tableView: DottTableView!
    @IBOutlet weak var filterButton: FilterButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var textLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        fetchVehicleList()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        filterButton.isUserInteractionEnabled = false
        bind(to: viewModel)
        viewModel?.checkUserDefaultsContent()
    }
    
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        let vehicleFilterVC = FilterVehicleViewController(nibName: Constants.vehicleFilterNibName, bundle: nil)
        vehicleFilterVC.viewModel = FilterVehicleViewModel()
//        if #available(iOS 15.0, *) {
//            if let presentationController = vehicleFilterVC.presentationController as? UISheetPresentationController {
//                presentationController.detents = [.medium()]
//            }
//        } else {
//            // Fallback on earlier versions
//        }
        vehicleFilterVC.delegate = self
        self.present(vehicleFilterVC, animated: true)
    }
    
    private func bind(to viewModel: FleetViewModelProtocol?) {
        viewModel?.checkUserDefaults.observe(on: self) { [weak self] value in
            guard let value = value, let self = self else {return}
            self.filterButton.isFilterActive = value
        }
      
        viewModel?.isError.observe(on: self) { [weak self] status in
            guard let status = status, let self = self else {return}
            if status {
                self.textLabel.isHidden = false
                self.textLabel.text = Constants.Messages.alertMessage
                self.fetchVehicleList()
            } else {
                self.spinner.stopAnimating()
                self.filterButton.isUserInteractionEnabled = true
                self.textLabel.isHidden = true
                self.tableView.reloadData()
            }
        }
        viewModel?.isFiltered.observe(on: self) { [weak self] status in
            guard let status = status, let self = self else {return}
            self.filterButton.isFilterActive = status
        }
    }

}



extension FleetViewController: FleetFilteringProtocol, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Table View Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.incomingVehicleData.count ?? 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        if let receivedData = viewModel?.incomingVehicleData {
            let singleVehicle = receivedData[indexPath.row]
            cell.textLabel?.text = singleVehicle.identificationCode
            if let vehicleImageName = viewModel?.mapScooterColorToVehicle(color: singleVehicle.color) {
             cell.imageView?.image = UIImage(named: "icon/\(vehicleImageName)")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vehicleDetailVC = VehicleDetailViewController(nibName: Constants.vehicleDetailNibName, bundle: nil)
//        if #available(iOS 15.0, *) {
//            if let presentationController = vehicleDetailVC.presentationController as? UISheetPresentationController {
//                presentationController.detents = [.medium()]
//            }
//        } else {
//            // Fallback on earlier versions
//        }
        present(vehicleDetailVC, animated: true, completion: nil)
        vehicleDetailVC.identificationCodeString = viewModel?.incomingVehicleData[indexPath.row].identificationCode
        vehicleDetailVC.qrCodeImageURL = viewModel?.incomingVehicleData[indexPath.row].qrURL
        self.present(vehicleDetailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK: - Filtering Fleet List With Switch Status
    func filterVehicleListWithSwitchState() {
        viewModel?.filterVehicleListByScooterColors()
    }
    
    
    //MARK: - Fetching Vehicle List
    func fetchVehicleList() {
        spinner.startAnimating()
        viewModel?.getVehicleData()
    }

}

