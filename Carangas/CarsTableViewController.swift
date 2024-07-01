//
//  CarsTableViewController.swift
//  Carangas
//
//  Created by Eric Brito on 21/10/17.
//  Copyright © 2017 Eric Brito. All rights reserved.
//

import UIKit

class CarsTableViewController: UITableViewController {
    
    var cars: [Car] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCars()
    }
    
    func loadCars() {
        REST.loadCars(onComplete: { (cars) in
            self.cars = cars
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) {(error) in
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let car = cars[indexPath.row]
        cell.textLabel?.text = car.name
        cell.detailTextLabel?.text = car.brand

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let carToDelete = cars[indexPath.row]
            REST.delete(car: carToDelete) { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.cars.remove(at: indexPath.row)
                        self.tableView.deleteRows(at: [indexPath], with: .automatic)
                    }
                } else {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Erro", message: "Não foi possível deletar o carro.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "viewSegue" {
              let vc = segue.destination as! CarViewController
              if let indexPath = tableView.indexPathForSelectedRow {
                  vc.car = cars[indexPath.row]
              }
          }
      }
}
