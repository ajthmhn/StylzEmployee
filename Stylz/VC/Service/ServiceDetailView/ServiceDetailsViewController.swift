////
////  ServiceDetailsViewController.swift
////  Stylz
////
////  Created by WC_Macmini on 27/02/23.
////
//
//import UIKit
//import StylzWebkit
//
//
//class ServiceDetailsViewController: UIViewController {
//
//    struct VCConst {
//        static let cellId = "barber_cell_id"
//    }
//    
//    @IBOutlet var desHeight: NSLayoutConstraint!
//    @IBOutlet var lblDes: UILabel!
//    @IBOutlet var lblNAme: UILabel!
//    @IBOutlet var lblDuration: UILabel!
//    @IBOutlet var lblPrice: UILabel!
//    @IBOutlet var lblAmount: UILabel!
//    @IBOutlet var lblDurationHead : UILabel!
//    @IBOutlet var lblPriceHad : UILabel!
//    @IBOutlet var lblEmployee : UILabel!
//    @IBOutlet var imgUser : UIImageView!
//
//    
//    var selectedBarber = -1
//    var selectedService : Services?
//    var selectedEmployee : Employee?
//    var parents : ServiceViewController?
//    var searchView : SearchViewController?
//    var isWalkins = false
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        if selectedService == nil{
//            lblEmployee.text = "Services"
//            lblAmount.text = ""
//            lblPriceHad.text = ""
//            lblDurationHead.text = ""
//            lblNAme.text =  selectedEmployee?.first_name
//            lblAmount.text = ""
//            lblDuration.text = selectedEmployee?.phone
//            lblDes.text = ""
//            self.desHeight.constant = 0
//            setImage(imageView: imgUser, url: selectedEmployee?.image ?? "")
//            
//            let attrs3 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
//            let attrs4 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
//            let attributedString3 = NSMutableAttributedString(string:"Add to Basket - ", attributes:attrs3 as [NSAttributedString.Key : Any])
//            //let price = String.init(format: "%.2f", trensingProducts[indexPath.item].offer_price ?? 0.0)
//            let attributedString4 = NSMutableAttributedString(string:"\("0.0") SAR", attributes:attrs4 as [NSAttributedString.Key : Any])
//            attributedString3.append(attributedString4)
//            lblPrice.attributedText = attributedString3
//            
//        }else{
//            imgUser.image = UIImage(named: "scissor")
//            lblPriceHad.text = "Rate"
//            lblEmployee.text = "Employees"
//            let attrs3 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
//            let attrs4 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
//            let attributedString3 = NSMutableAttributedString(string:"Add to Basket - ", attributes:attrs3 as [NSAttributedString.Key : Any])
//            //let price = String.init(format: "%.2f", trensingProducts[indexPath.item].offer_price ?? 0.0)
//            let attributedString4 = NSMutableAttributedString(string:"\(selectedService?.amount ?? "") SAR", attributes:attrs4 as [NSAttributedString.Key : Any])
//            attributedString3.append(attributedString4)
//            lblPrice.attributedText = attributedString3
//            lblDurationHead.text = "Duration "
//            lblNAme.text =  LocalizationSystem.sharedInstance.getLanguage() == "ar" ? selectedService?.name_ar : selectedService?.name_en
//            lblAmount.text = "SAR \(selectedService?.amount ?? "")"
//            lblDuration.text = selectedService?.duration
//            lblDes.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? selectedService?.description_ar : selectedService?.description_en
//            self.desHeight.constant = self.lblDes.getSize(constrainedWidth:self.view.frame.width).height
//
//        }
//        
//
//    }
//    
//    @IBAction func btnAddCart(_ sender: Any) {
//        
//        if selectedService == nil{
//            if selectedBarber == -1{
//                showAlert(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "select_service", comment: ""), sender: self)
//                return
//            }
//            
//            var details = [String:Any]()
//            details["customer_id"] = self.selectedEmployee?.id
//            details["customer_image"] = self.selectedEmployee?.image
//            details["customer_name"] =  self.selectedEmployee?.first_name
//            details["service_id"] = self.selectedEmployee?.services[selectedBarber].service
//            details["service_name_en"] = self.selectedEmployee?.services[selectedBarber].name_en
//            details["service_name_ar"] = self.selectedEmployee?.services[selectedBarber].name_ar
//            details["price"] = self.selectedEmployee?.services[selectedBarber].amount
//            
//            print(details)
//            saveCart(details: details)
//            
//        }else{
//            if selectedBarber == -1{
//                showAlert(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "select_employee", comment: ""), sender: self)
//                return
//            }
//            
//            var details = [String:Any]()
//           // details["customer_id"] = self.selectedService?.employees[self.selectedBarber].employee
//            details["customer_image"] = self.selectedService?.employees[self.selectedBarber].image
//            details["customer_name"] =  self.selectedService?.employees[self.selectedBarber].first_name
//            details["service_id"] = self.selectedService?.id
//            details["service_name_en"] = self.selectedService?.name_en
//            details["service_name_ar"] = self.selectedService?.name_ar
//            details["price"] = self.selectedService?.amount
//            print(details)
//            saveCart(details: details)
//        }
//        
//        isWalkin(value: isWalkins)
//        
//        if parents != nil{
//            showSuccess(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "service_added", comment: ""), view: (parents?.view)!)
//            parents?.viewCart.isHidden = false
//            parents?.lblCount.text = "\(getCartData()?.count ?? 0)"
//            animationScaleEffectSingle(view: (parents?.viewCart)!)
//        }else{
//            showSuccess(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "service_added", comment: ""), view: (searchView?.view)!)
//        }
//        self.dismiss(animated: true)
//    }
//
//}
//
//extension  ServiceDetailsViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if selectedService == nil{
//            return selectedEmployee?.services.count ?? 0
//        }else{
//            return selectedService?.employees.count ?? 0
//
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: VCConst.cellId, for: indexPath) as! BarberColCell
//        cell.layer.borderColor = UIColor.lightGray.cgColor
//        cell.layer.cornerRadius = 20
//        cell.layer.masksToBounds = true
//        if selectedService == nil{
//          
//            cell.lblName.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? selectedEmployee?.services[indexPath.row].name_ar : selectedEmployee?.services[indexPath.row].name_en
//            
//            cell.lblPrice.text = "SAR \(selectedEmployee?.services[indexPath.row].amount ?? "")"
//            cell.imgBarber.image = UIImage(named: "scissor")
//            cell.viewRating.isHidden = true
//          
//            if selectedBarber == indexPath.item{
//                cell.backgroundColor = UIColor(hexString: "1B263B")
//                cell.lblName.textColor = UIColor.white
//                cell.lblPrice.textColor = UIColor.white
//                cell.layer.borderWidth = 0
//                animationScaleEffectSingle(view: cell)
//            }
//            else{
//                cell.layer.borderWidth = 0.5
//                cell.backgroundColor = UIColor.white
//                cell.lblName.textColor = UIColor.black
//                cell.lblPrice.textColor = UIColor.black
//            }
//            
//        }
//        else{
//            cell.viewRating.isHidden = false
//            cell.lblName.text = selectedService?.employees[indexPath.row].first_name
////            cell.lblRating.text = selectedService?.employees[indexPath.row].employee_rating
//            cell.lblPrice.text = "SAR \(selectedService?.amount ?? "")"
//            setImage(imageView: cell.imgBarber, url: selectedService?.employees[indexPath.row].image ?? "")
//            
//            if selectedBarber == indexPath.item{
//                cell.backgroundColor = UIColor(hexString: "1B263B")
//                cell.lblName.textColor = UIColor.white
//                cell.lblPrice.textColor = UIColor.white
//                cell.layer.borderWidth = 0
//                animationScaleEffectSingle(view: cell)
//            }else{
//                cell.layer.borderWidth = 0.5
//                cell.backgroundColor = UIColor.white
//                cell.lblName.textColor = UIColor.black
//                cell.lblPrice.textColor = UIColor.black
//            }
//        }
//       
//        
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 114, height: 155)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if selectedService == nil{
//            let attrs3 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
//            let attrs4 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
//            let attributedString3 = NSMutableAttributedString(string:"Add to Basket - ", attributes:attrs3 as [NSAttributedString.Key : Any])
//            //let price = String.init(format: "%.2f", trensingProducts[indexPath.item].offer_price ?? 0.0)
//            let attributedString4 = NSMutableAttributedString(string:"\(selectedEmployee?.services[indexPath.row].amount ?? "") SAR", attributes:attrs4 as [NSAttributedString.Key : Any])
//            attributedString3.append(attributedString4)
//            lblPrice.attributedText = attributedString3
//        }
//        selectedBarber = indexPath.item
//        collectionView.reloadData()
//    }
//}
//
//extension UILabel {
//    func getSize(constrainedWidth: CGFloat) -> CGSize {
//        return systemLayoutSizeFitting(CGSize(width: constrainedWidth, height: UIView.layoutFittingCompressedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
//    }
//}
