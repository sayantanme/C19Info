//
//  OxygenData.swift
//  C19Info
//
//  Created by Sayantan Chakraborty on 24/04/21.
//

import Foundation

// MARK: - Oxygen
struct OxygenData: Decodable {
    let data: [O2Data]
}

// MARK: - Datum
struct O2Data: Decodable , Identifiable {
    let availability: String?
    let city: String?
    let comment, companyName: String?
    let createdTime: Date?
    let datumDescription: String?
    let district: String?
    let emailID: String?
    let homeDeliveryAvailable: String?
    var id: String
    let instructions:String?
    let lastVerifiedOn: Date?
    let name: String?
    let phone1: String?
    let phone2: String?
    let sourceLink: String?
    let sourceName: String?
    let state: String?
    let type: [String]?
    let verificationStatus: String?
    let verifiedBy: String?
    
    enum CodingKeys: String, CodingKey {
        case availability, city, comment, companyName, createdTime, datumDescription, district, emailID, homeDeliveryAvailable, id,
             instructions, lastVerifiedOn, name, phone1, phone2, sourceLink, sourceName, state, type, verificationStatus, verifiedBy
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {availability = try container.decode(String?.self, forKey: .availability)} catch {availability = nil}
        do {city = try container.decode(String?.self, forKey: .city)} catch {city = nil}
        do {comment = try container.decode(String?.self, forKey: .comment)} catch {comment = nil}
        do {companyName = try container.decode(String?.self, forKey: .companyName)} catch {companyName = nil}
        
        let interimCreatedDate = try container.decode(String.self, forKey: .createdTime)
        if let iDate = interimCreatedDate.convertToDate() {
            createdTime = iDate
        } else {
            createdTime = nil
        }
        
        do {datumDescription = try container.decode(String?.self, forKey: .datumDescription)} catch {datumDescription = nil}
        do {district = try container.decode(String?.self, forKey: .district)} catch {district = nil}
        do {emailID = try container.decode(String?.self, forKey: .emailID)} catch {emailID = nil}
        do {homeDeliveryAvailable = try container.decode(String?.self, forKey: .homeDeliveryAvailable)} catch {homeDeliveryAvailable = nil}
        id = try container.decode(String.self, forKey: .id)
        do {instructions = try container.decode(String?.self, forKey: .instructions)} catch {instructions = nil}
        
        do {
            if let interimVerifiedDate = try container.decode(String?.self, forKey: .lastVerifiedOn), let processedDate = interimVerifiedDate.convertToDate() {
                lastVerifiedOn = processedDate
            } else {
                lastVerifiedOn = nil
            }
            
        } catch {lastVerifiedOn = nil}
        
        do {name = try container.decode(String?.self, forKey: .name)} catch {name = nil}
        
        do {
            if let interimValue = try container.decode(Double?.self, forKey: .phone1) {
                phone1 = "\(interimValue)"
            } else {
                phone1 = nil
            }
            
        } catch { phone1 = nil}
        do {
            if let interimValue = try container.decode(Int?.self, forKey: .phone2) {
                phone2 = "\(interimValue)"
            } else {
                phone2 = nil
            }
            
        } catch { phone2 = nil }
        do {sourceLink = try container.decode(String?.self, forKey: .sourceLink)} catch { sourceLink = nil }
        do {sourceName = try container.decode(String?.self, forKey: .sourceName)} catch {sourceName = nil }
        do {state = try container.decode(String?.self, forKey: .state)} catch { state = nil}
        do {type = try container.decode(Array?.self, forKey: .type)} catch {type = nil}
        do {verificationStatus = try container.decode(String.self, forKey: .verificationStatus)} catch {verificationStatus = nil}
        
        do {verifiedBy = try container.decode(String.self, forKey: .verifiedBy)} catch DecodingError.typeMismatch {verifiedBy = nil}
    }
}

enum State {
    case bihar
    case chhattisgarh
    case delhiNCT
    case gujarat
    case haryana
    case jharkhand
    case madhyaPradesh
    case maharashtra
    case rajasthan
    case uttarPradesh
    case westBengal
}

//str TypeElement: Decodable {
//    case cans
//    case concentrator
//    case cylinder
//    case refil
//}

extension Optional where Wrapped == String {
    var text: String {
        self ?? ""
    }
}

extension String {
    func convertToDate() -> Date? {
        let dateFormatter =  ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate,
                                                  .withTime,
                                                  .withDashSeparatorInDate,
                                                  .withColonSeparatorInTime]
        return dateFormatter.date(from:self)
    }
}

extension Date {
    func convertToString() -> String? {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd MMM yy HH:mm"
        return dateformatter.string(from: self)
    }
}
