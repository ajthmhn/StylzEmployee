//
//  SearchViewController.swift
//  Stylz
//
//  Created by WC_Macmini on 27/02/23.
//

import UIKit
import StylzWebkit

class SearchViewController: BaseViewController {
    
    struct VCConst {
        static let serviceCellId = "service_cell_id"
    }
    
    @IBOutlet var txtSearch: UITextField!
    @IBOutlet var viewSearch: UIView!
    @IBOutlet var tblServicew: UITableView!
    @IBOutlet var viewCart: UIView!
    @IBOutlet var lblCount: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var bottomSpace: NSLayoutConstraint!
    
    var servicesList = [Services]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchBar()
        localizeView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchSearhedTermData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setInitialViewForCart()
    }
    
    @IBAction func btnCart(_ sender: Any) {
       
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.cart) as! CartViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    @objc func textFieldDidChange(textField : UITextField){
        let search_term = txtSearch.text ?? ""
        
        getSearchedData(searhTerm:  search_term)
    }
    
}




