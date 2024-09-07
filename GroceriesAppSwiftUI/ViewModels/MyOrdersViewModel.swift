//
//  MyOrdersViewModel.swift
//  GroceriesAppSwiftUI
//
//  Created by rafiul hasan on 4/9/24.
//

import Foundation
import SwiftUI

class MyOrdersViewModel: ObservableObject {
    
    static var shared: MyOrdersViewModel = MyOrdersViewModel()
    
    @Published var showError = false
    @Published var errorMessage = ""
    @Published var listArr: [MyOrderModel] = []
    
    init() {
        serviceCallList()
    }
    
    //MARK: ServiceCall
    func serviceCallList() {
        ServiceCall.post(parameter: [:], path: Globs.SV_MY_ORDERS_LIST, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.listArr = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                        return MyOrderModel(dict: obj as? NSDictionary ?? [:])
                    })
                    
                } else {
                    self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }
    }
}
