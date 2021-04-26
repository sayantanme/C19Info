//
//  OxygenDataVM.swift
//  C19Info
//
//  Created by Sayantan Chakraborty on 24/04/21.
//

import Foundation

protocol URLProvider {
    func getOxyGenURL() -> String
}

struct Constants: URLProvider {
    private enum URLs: String {
        case oxygen = "https://life-api.coronasafe.network/data/oxygen.json"
        case ambulance = "https://life-api.coronasafe.network/data/ambulance.json"
        case helplineNumbers = "https://life-api.coronasafe.network/data/helpline.json"
        case hospitals_beds = "https://life-api.coronasafe.network/data/hospital_bed_icu.json"
    }
    
    func getOxyGenURL() -> String {
        URLs.oxygen.rawValue
    }
}
class OxygenVM: ObservableObject {
    @Published private(set) var oxygenModel: [O2Data] = []
    private(set) var networkCore: NetworkManagerProtocol?
    
    init() {
        networkCore = NetworkManager()
    }
    
    //MARK: - Intents
    func getOxygenRelatedInfo() {
        
        networkCore?.fetchO2Data(completionHandler: { (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    //self.oxygenModel = data.data.sorted(by: { ($0.lastVerifiedOn ?? Date.distantPast).compare($1.lastVerifiedOn ?? Date.distantPast) == .orderedDescending})
                    self.oxygenModel = data.data
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
