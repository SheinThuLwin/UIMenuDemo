//
//  ViewController.swift
//  UIMenuDemo
//
//  Created by ut-i02 on 23/02/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnPhIDD: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if #available(iOS 14.0, *) {
            setupPhoneIDDMenu(btn: btnPhIDD)
        } else {
            // Fallback on earlier versions
        }
    }
    
    @available(iOS 14.0, *)
    private func setupPhoneIDDMenu(btn: UIButton){
        btn.showsMenuAsPrimaryAction = true
        
        let allIDD = getPhIDD()
        var actions: [UIAction] = []
        for idd in allIDD{
            let action = UIAction(title: idd.country, discoverabilityTitle: idd.idd) { (action) in
                print("Select idd >> \(action.discoverabilityTitle ?? "")")
                let btnTitle = "+\(action.discoverabilityTitle ?? "")-9-"
                self.btnPhIDD.setTitle(btnTitle, for: .normal)
            }
            actions.append(action)
        }
        let menu = UIMenu(title: "IDD", options: .displayInline, children: actions)
        
        btn.menu = menu
        
    }
    
    private func getPhIDD() -> [(country: String, idd: String)]{
        var allIdd: [(country: String, idd: String)] = []
        
        allIdd.append(("Afghanistan", "93"))
        allIdd.append(("Albania", "355"))
        allIdd.append(("Algeria", "213"))
        allIdd.append(("American Samoa", "1684"))
        allIdd.append(("Andorra", "376"))
        allIdd.append(("Angola", "244"))
        allIdd.append(("Anguilla", "1264"))
        allIdd.append(("Antigua and Barbuda", "1268"))
        allIdd.append(("Argentina", "54"))
        allIdd.append(("Armenia", "374"))
        allIdd.append(("Aruba", "297"))
        allIdd.append(("Ascension", "247"))
        allIdd.append(("Australia", "61"))
        allIdd.append(("Australian External Territories", "672"))
        allIdd.append(("Austria", "43"))
        allIdd.append(("Azerbaijan", "994"))
        allIdd.append(("Bahamas", "1242"))
        allIdd.append(("Bahrain", "973"))
        allIdd.append(("Bangladesh", "880"))
        allIdd.append(("Barbados", "1246"))
        allIdd.append(("Barbuda", "1268"))
        allIdd.append(("Belarus", "375"))
        allIdd.append(("Belgium", "32"))
        allIdd.append(("Belize", "501"))
        allIdd.append(("Benin", "229"))
        allIdd.append(("Bermuda", "1441"))
        allIdd.append(("Bhutan", "975"))
        allIdd.append(("Bolivia", "591"))
        allIdd.append(("Bosnia and Herzegovina", "387"))
        allIdd.append(("Botswana", "267"))
        allIdd.append(("Brazil", "55"))
        allIdd.append(("British Indian Ocean Territory", "246"))
        allIdd.append(("British Virgin Islands", "1284"))
        allIdd.append(("Brunei", "673"))
        allIdd.append(("Bulgaria", "359"))
        allIdd.append(("Burkina Faso", "226"))
        allIdd.append(("Burundi", "257"))
        
        return allIdd
    }


}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

