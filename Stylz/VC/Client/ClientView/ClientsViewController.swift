//
//  ClientsViewController.swift
//  Stylz
//
//  Created by WC_Macmini on 12/03/23.
//

import UIKit
import StylzWebkit

class ClientsViewController: BaseViewController {
    
    struct VCConst {
        static let cellId  = "client_cell_id"
        static let groupCellId = "category_cell_id"
    }
    
    
    @IBOutlet var btnAll: UIButton!
    @IBOutlet var btnRegular: UIButton!
    @IBOutlet var tblServicew: UITableView!
    @IBOutlet var txtSearch: UITextField!
    @IBOutlet var lblHead: UILabel!
    @IBOutlet var btnBook: UIButton!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var searchView: UIStackView!
    @IBOutlet var groupView: UIView!
    @IBOutlet var viewCol: [UIView]!
    @IBOutlet var colGroups: UICollectionView!
    
    var selectedGroup = 0
    var selectedGroupID = -1
    var selectedClient = -1
    
    
    var filteredEmployeeList = [Employee]()
    var EmployeeList = [Employee]()
    var groups = [Categories]()
    
    var isRescedule = false
    var date = ""
    var time = ""
    var groupId = 7
    var firstTime = true
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handleBackBtn()
        
        configTf()
        
        localizeeView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fetchData(getOnlyClients: false)
    }
    
    
    @IBAction func btnAdd(_ sender: Any) {
        moveToAddNewClientView()
    }
    
  
    @IBAction func btynBook(_ sender: Any) {
        
        if selectedClient == -1{
            showAlert(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "select_client", comment: ""), sender: self)
            return
        }
        
        bookAppointmnet()
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
    
        if self.searchView.isHidden{
            setSearchView(isHidden: false,withAnimation: true)
            return
        }
        
        self.navigationController?.popViewController(animated: false)
    }
}


//MARK: - move to add new client view

extension ClientsViewController{
    
    func moveToAddNewClientView(){
      
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.addClientWithNumber) as! AddClientWithNumberViewController
        
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        
        vc.addClientDelegate = { employees, OTP in
            DispatchQueue.main.async {
                self.dismiss(animated: false)
                
                if let employees{
                    self.handleNewClient(employees: employees)
                }
                
                if let OTP{
                    self.moveToOTPVerificationView(otp: OTP)
                }
            }
        }
        
        self.present(vc, animated:false)
    }
    
 
    func setSearchView(isHidden:Bool, withAnimation:Bool = false)
    {
        self.searchView.isHidden = isHidden
        self.groupView.isHidden = isHidden
        
        if withAnimation{
            animationScaleEffect(view: viewCol)
            self.fetchData(getOnlyClients: true)
        }
    }
    
    
    func handleNewClient(employees:[Employee]){
        
        let msg = LocalizationSystem
            .sharedInstance.localizedStringForKey(key: K.MYStrings.clietFound, comment: "")
        showSuccess(title: "", subTitle:msg , view: self.view)

        setSearchView(isHidden: true)
        self.filteredEmployeeList = employees
        self.tblServicew.reloadData()
    }
    
   
    func moveToOTPVerificationView(otp:Int){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.otpView) as! OTPViewController
        vc.isFromClietView = true
        vc.otp = "\(otp)"
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}




