//
//  ViewController.swift
//  UIMenuDemo
//
//  Created by ut-i02 on 23/02/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnPhIDD: UIButton!
    private var allIdd: [(country: String, idd: String)] = []
    private var phIddSelectedIndex: Int = 0{
        didSet{
            setPhIddSelectedIndex(index: phIddSelectedIndex)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Form"
        setPhIddSelectedIndex(index: phIddSelectedIndex)
        if #available(iOS 14.0, *) {
            setupPhoneIDDMenu(btn: btnPhIDD)
        } else {
            btnPhIDD.addTarget(self, action: #selector(btnPhIDDTouchUpInside(_:)), for: .touchUpInside)
        }
    }
    
    @objc fileprivate func btnPhIDDTouchUpInside(_ sender: UIButton) {
        let vc = CountryIDDSelectionVC.getNewinstance(countryIdds: getPhIDD())
        vc.selectDelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @available(iOS 14.0, *)
    private func setupPhoneIDDMenu(btn: UIButton){
        btn.showsMenuAsPrimaryAction = true
        
        let allIDD = getPhIDD()
        var actions: [UIAction] = []
        var index = 0
        for idd in allIDD{
            let selectedIndex = index
            let action = UIAction(title: idd.country, discoverabilityTitle: idd.idd) { (action) in
                self.phIddSelectedIndex = selectedIndex
            }
            actions.append(action)
            index += 1
        }
        let menu = UIMenu(title: "IDD", options: .displayInline, children: actions)
        
        btn.menu = menu
        
    }
    
    private func setPhIddSelectedIndex(index: Int){
        let selectedPhIdd = getPhIDD()[index]
        btnPhIDD.setTitle("+\(selectedPhIdd.idd)-9-", for: .normal)
    }
    
    private func getPhIDD() -> [(country: String, idd: String)]{
        if allIdd.isEmpty{
            allIdd = []
            
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
        }
        
        return allIdd
    }
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ViewController: DataSelectDelegate{
    func dataSelected(index: Int) {
        let selected = allIdd[index]
        phIddSelectedIndex = index
        print("select >> \(index), \(selected.country), \(selected.idd)")
    }
}
