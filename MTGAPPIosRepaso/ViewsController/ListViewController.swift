//
//  ViewController.swift
//  MTGAPPIosRepaso
//
//  Created by Tardes on 30/6/26.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    var productList: [Product] = []
    var productListFiltered: [Product] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Filter..."
        navigationItem.searchController = searchController
        
        searchProducts(query: "")
    }
    
    func searchProducts(query: String){
        Task {
            print("Buscando productos...")
            productList = await ApiService.getProductList()
            productListFiltered = productList
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productListFiltered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = productListFiltered[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Product Cell", for: indexPath) as! ProductViewCell
        cell.configure(with: product)
        return cell
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterProducts(query: searchText)
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filterProducts(query: searchBar.text ?? "")
        }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filterProducts(query: "")
    }
    func filterProducts(query: String){
        if !query.isEmpty {
            let searchTerms = query.lowercased().split(separator: " ").map(String.init)

            productListFiltered = productList.filter { product in
                let title = product.title.lowercased()
                let category = product.category.lowercased()

                // coincide si encuentra al menos una palabra
                return searchTerms.contains { term in
                    title.contains(term) || category.contains(term)
                }
                
                // coincide solo si encuentra todas las palabras
                /*return searchTerms.allSatisfy { term in
                    title.contains(term) || category.contains(term)
                }*/
            }
        } else {
            productListFiltered = productList
        }
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DetailViewController
        let indexPath = tableView.indexPathForSelectedRow!
        let product = productListFiltered[indexPath.row]
        destination.product = product
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

