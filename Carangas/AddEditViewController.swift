//
//  AddEditViewController.swift
//  Carangas
//
//  Created by Eric Brito.
//  Copyright © 2017 Eric Brito. All rights reserved.
//

import UIKit

class AddEditViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tfBrand: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var scGasType: UISegmentedControl!
    @IBOutlet weak var btAddEdit: UIButton!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var car: Car!

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        if car != nil {
            tfBrand.text = car.brand
            tfName.text = car.name
            tfPrice.text = "\(car.price)" 
            scGasType.selectedSegmentIndex = car.gasType
            btAddEdit.setTitle("Alterar carro", for: .normal)
        }
    }
    
    // MARK: - IBActions
    @IBAction func addEdit(_ sender: UIButton) {
        if car == nil {
            car = Car()
        }
        car.name = tfName.text ?? ""
        car.brand = tfBrand.text ?? ""
        car.price = Double(tfPrice.text ?? "0") ?? 0.0
        car.gasType = scGasType.selectedSegmentIndex
        
        loading.startAnimating()
        
        if car._id == nil {
            REST.save(car: car) { success in
                self.handleResponse(success: success, action: "salvar")
            }
        } else {
            REST.update(car: car) { success in
                self.handleResponse(success: success, action: "atualizar")
            }
        }
    }
    
    func handleResponse(success: Bool, action: String) {
        DispatchQueue.main.async {
            self.loading.stopAnimating()
            if success {
                self.goBack()
            } else {
                let alert = UIAlertController(title: "Erro", message: "Não foi possível \(action) o carro.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
