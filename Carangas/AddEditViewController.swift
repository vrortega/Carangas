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
        
        REST.save(car: car) { (success) in
            DispatchQueue.main.async {
                self.loading.stopAnimating()
                if success {
                    self.goBack()
                } else {
                    // Exibir uma mensagem de erro para o usuário
                    let alert = UIAlertController(title: "Erro", message: "Não foi possível salvar o carro.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
