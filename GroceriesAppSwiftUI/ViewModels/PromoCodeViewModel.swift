//
//  PromoCodeViewModel.swift
//  GroceriesAppSwiftUI
//
//  Created by rafiul hasan on 4/9/24.
//

import Foundation
import SwiftUI

class PromoCodeViewModel: ObservableObject {
    
    static var shared: PromoCodeViewModel = PromoCodeViewModel()
    
    @Published var showError = false
    @Published var errorMessage = ""
    @Published var listArr: [PromoCodeModel] = []
    
    init() {
        serviceCallList()
    }
    
    //MARK: ServiceCall
    func serviceCallList(){
        ServiceCall.post(parameter: [:], path: Globs.SV_PROMO_CODE_LIST, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.listArr = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                        return PromoCodeModel(dict: obj as? NSDictionary ?? [:])
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
