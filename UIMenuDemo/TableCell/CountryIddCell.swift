//
//  CountryIddCell.swift
//  UIMenuDemo
//
//  Created by ut-i02 on 23/02/2022.
//

import UIKit

class CountryIddCell: UITableViewCell {

    static let Identifier = "CountryIddCell"
    static let NibName = "CountryIddCell"
    static let height: CGFloat = 92
    
    @IBOutlet weak var vwBase: UIView!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblIdd: UILabel!

    static func registerForCell(at: UITableView){
        let cell = UINib(nibName: NibName, bundle: nil)
        at.register(cell, forCellReuseIdentifier: Identifier)
    }
    
    static func getReusableCell(_ tblView: UITableView, indexPath: IndexPath, country: String = "", idd: String = "") -> CountryIddCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: Identifier, for: indexPath) as! CountryIddCell
       
        cell.lblCountry.text = country
        cell.lblIdd.text = idd
        
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
