//
//  CountryIDDSelectionVC.swift
//  UIMenuDemo
//
//  Created by ut-i02 on 23/02/2022.
//

import UIKit

protocol DataSelectDelegate {
    func dataSelected(index: Int)
}

class CountryIDDSelectionVC: UIViewController {
    
    private static let nibName = "CountryIDDSelectionVC"
    
    @IBOutlet weak var tbl: UITableView!
    @IBOutlet weak var vwNotFound: UIView!
    
    private let searchBarController = UISearchController(searchResultsController: nil)
    public var selectDelegate: DataSelectDelegate? = nil
    
    private var countryIdds: [(index: Int, country: String, idd: String)] = []
    private var filtered: [(index: Int, country: String, idd: String)] = []
    

    static func getNewinstance(countryIdds: [(country: String, idd: String)]) -> CountryIDDSelectionVC{
        let vc = CountryIDDSelectionVC(nibName: nibName, bundle: nil)
        var index: Int = -1
        vc.countryIdds = countryIdds.map({
            index += 1
            return (index, $0.country, $0.idd)
        })
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Please Select Country"
        vwNotFound.isHidden = true
        filtered = countryIdds
        setup(searchBarController: searchBarController)
        setup(tableView: tbl)
    }
    
    private func setup(searchBarController: UISearchController){
        self.navigationItem.searchController = searchBarController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        searchBarController.delegate = self
        searchBarController.searchBar.delegate = self
    }

    private func setup(tableView: UITableView){
        CountryIddCell.registerForCell(at: tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CountryIDDSelectionVC: UISearchControllerDelegate{
    
}

extension CountryIDDSelectionVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if searchText.count < 1 {
            //Not search
            filtered = countryIdds
            tbl.reloadData()
            return
        }
        
        //Search
        filtered = countryIdds.filter({ $0.country.lowercased().contains(searchText) || $0.idd.lowercased().contains(searchText)  })
        vwNotFound.isHidden = !filtered.isEmpty
        
        tbl.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filtered = countryIdds
        tbl.reloadData()
    }
}

extension CountryIDDSelectionVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filtered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let countryIdd = filtered[indexPath.row]
        let country = countryIdd.country
        let idd = "+\(countryIdd.idd)"
        return CountryIddCell.getReusableCell(tableView, indexPath: indexPath, country: country, idd: idd)
    }
}

extension CountryIDDSelectionVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBarController.searchBar.endEditing(true)
        self.navigationController?.popViewController(animated: true)
        if let delegate = selectDelegate{
            delegate.dataSelected(index: filtered[indexPath.row].index)
        }
    }
}
