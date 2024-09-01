//
//  APIHandler_Search.swift
//  Stylz
//
//  Created by abcd on 26/05/2024.
//

import Foundation
import UIKit


//MARK: - get data

extension SearchViewController{
    
    func fetchSearhedTermData(){
        
        let search_term = self.txtSearch.text ?? ""
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.getSearchedData(searhTerm: search_term)
        }
    }
    
    
    func getSearchedData(searhTerm:String){
        
        //   let loadingIndicator = getIndicator(controller: self)
        
        print("fetching dataaa")
        
        var search_term = searhTerm
        if (searhTerm.isEmptyOrWhitespace() == true){
            search_term = ""
        }
        
        let  branchID = getBrannchCode()
        
        self.servicesList.removeAll()
        
        print("seaarch term: \(searhTerm)")
        
        let request = SearchRequest(searchTerm: search_term.lowercased(), branchID: branchID)
        
        let resource = SerachResource()
        resource.searchAll(request: request) { services, errMsg in
            
            DispatchQueue.main.async {
                
                if let services{
                    self.servicesList = services
                }
                
                self.updateSearchedData()
            }
        }
        
    }
    
    
    func updateSearchedData(){
        self.tblServicew.reloadData()
        
        let label = getNoDataLabel(tableORColView: tblServicew)
        
        if self.servicesList.count == 0{
            self.tblServicew.backgroundView = label
        }else{
            self.tblServicew.backgroundView = nil
        }
    }
    
}

