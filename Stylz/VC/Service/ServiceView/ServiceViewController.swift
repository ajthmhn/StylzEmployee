//
//  ServiceViewController.swift
//  Stylz
//
//  Created by WC_Macmini on 27/02/23.
//

import UIKit
import StylzWebkit
import ImageSlideshow


class ServiceViewController: BaseViewController {
    
    struct VCConst {
        static let cellId = "category_cell_id"
        static let serviceCellId = "service_cell_id"
        static let employeeCellId = "employee_cell_id"
    }
    
    @IBOutlet var tblHeight: NSLayoutConstraint!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var colCategories: UICollectionView!
    @IBOutlet var tblServicew: UITableView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblAddress: UILabel!
    @IBOutlet var slider: ImageSlideshow!
    @IBOutlet var viewCart: UIView!
    @IBOutlet var imgTabs: [UIImageView]!
    @IBOutlet var lblTabs: [UILabel]!
    @IBOutlet var viewCol: UIView!
    @IBOutlet var lblCount: UILabel!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var bottomSpace: NSLayoutConstraint!
    
    @IBOutlet var lblRating: UILabel!
    
    var selectedCategoryID = 0
    var selectedService = 0
    var categories = [Categories]()
    var employeeList = [Employee]()
    var services = [Services]()
    
    var firstTime = true
    var isEmplooyee = false
    var isWalkin = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewCart.isHidden = true
        bottomSpace.constant = 0
        
        //let price = String.init(format: "%.2f", trensingProducts[indexPath.item].offer_price ?? 0.0)
        
        self.localizeView()
        
        self.setSliderImg()
        
        self.setTabView()
        
        fetchDataWihtoutLoader()
        
    }
    
    
        override func viewWillAppear(_ animated: Bool) {
            // fetchData(getOnlyServices: false)
        
            tblServicew.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
       
            self.handleWalkingCheckout()
        }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.setCartView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        tblServicew.removeObserver(self, forKeyPath: "contentSize")
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnSearch(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.search) as! SearchViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func btnCart(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.cart) as! CartViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func btnSelect(_ sender: UIButton) {
        
    }
    
    
    
    
    
    
}



//
//
////MARK: -  get employees //5
//extension ServiceViewController{
//
//    func getEmployees(){
//        self.employeeList.removeAll()
//
//        let gender = getGenderCode()
//        let branchID = getBrannchCode()
//
//        let request = GetEmployeesRequest(lat:"", lon: "", gender: gender,branchId:branchID,serviceID: nil,employeeID: nil)
//
//        let resource = GetEmployeesResources()
//        resource.getEmployees(request: request) { employees in
//
//            DispatchQueue.main.async {
//                if let employees{
//                    self.employeeList = employees
//                }
//                self.updateEmployeeView()
//            }
//        }
//    }
//
//    func updateEmployeeView(){
//        self.tblServicew.reloadData()
//
//        let label = getNoDataLabel(tableORColView: tblServicew)
//
//        if self.employeeList.count == 0{
//            self.tblServicew.backgroundView = label
//        }else{
//            self.tblServicew.backgroundView = nil
//        }
//    }
//}


////MARK: - handling apis
//
//extension ServiceViewController{
//
//
//    / Notify when all API calls are finished
//    apiGroup.notify(queue: .main) {
//        print("All API calls completed.")
//    }
//
//}



////MARK: - employee API
//extension ServiceViewController{
//
//
//    func getEmployees(){
//        let loadingIndicator = UIActivityIndicatorView(frame: self.view.bounds)
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.style = UIActivityIndicatorView.Style.large
//        loadingIndicator.startAnimating();
//
//        self.view.addSubview(loadingIndicator)
//
//        employeeList.removeAll()
//        StylzAPIFacade.shared.getEmployeeList { (aRes) in
//            DispatchQueue.main.async {
//                loadingIndicator.removeFromSuperview()
//            }
//
//            if aRes?.statusCode == 200{
//                if aRes?.json?["status"].boolValue == true{
//                    if let data = aRes?.json?["data"].array{
//                            for m in data{
//                                let booking = Employee(json: m)
//                                self.employeeList.append(booking)
//                            }
//
//                    }
//
//                DispatchQueue.main.async {
//                    self.tblServicew.reloadData()
//                    let label = UILabel()
//                    label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "no_data", comment: "")
//                    label.textAlignment = .center
//                    label.textColor = UIColor.darkGray
//                    label.sizeToFit()
//                    label.frame = CGRect(x: self.tblServicew.frame.width/2, y: self.tblServicew.frame.height/2, width: self.tblServicew.frame.width, height: 50)
//
//                    if self.employeeList.count == 0{
//                        self.tblServicew.backgroundView = label
//                    }else{
//                        self.tblServicew.backgroundView = nil
//                    }
//                }
//            }
//        }
//    }
//    }
//
//}



////MARK: - walking service API
//extension ServiceViewController{
//
//
//    func getWalkinCategories(){
//        let loadingIndicator = UIActivityIndicatorView(frame: self.view.bounds)
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.style = UIActivityIndicatorView.Style.large
//        loadingIndicator.startAnimating();
//
//        self.view.addSubview(loadingIndicator)
//
//        categories.removeAll()
//        StylzAPIFacade.shared.getWalkinService { (aRes) in
//            DispatchQueue.main.async {
//                loadingIndicator.removeFromSuperview()
//            }
//
//            if aRes?.statusCode == 200{
//                if aRes?.json?["status"].boolValue == true{
//
//                    if let data = aRes?.json?["data"].array{
//                            for m in data{
//                                let booking = Categories(json: m)
//                                self.categories.append(booking)
//                            }
//
//                    }
//
//                DispatchQueue.main.async {
//                    self.colCategories.reloadData()
//                    self.tblServicew.reloadData()
//
//                    let label = UILabel()
//                    label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "no_data", comment: "")
//                    label.textAlignment = .center
//                    label.textColor = UIColor.darkGray
//                    label.sizeToFit()
//                    label.frame = CGRect(x: self.tblServicew.frame.width/2, y: self.tblServicew.frame.height/2, width: self.tblServicew.frame.width, height: 50)
//
//                    if self.categories.count == 0{
//                        self.tblServicew.backgroundView = label
//                    }else{
//                        self.tblServicew.backgroundView = nil
//                    }
//                }
//            }
//        }
//    }
//    }
//}
