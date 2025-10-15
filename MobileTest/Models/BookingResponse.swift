import Foundation

struct BookingResponse: Codable {
    let shipReference: String
    let shipToken: String
    let canIssueTicketChecking: Bool
    let expiryTime: TimeInterval
    let duration: Int
    let segments: [Segment]
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           shipReference = try container.decode(String.self, forKey: .shipReference)
           shipToken = try container.decode(String.self, forKey: .shipToken)
           canIssueTicketChecking = try container.decode(Bool.self, forKey: .canIssueTicketChecking)
           duration = try container.decode(Int.self, forKey: .duration)
           segments = try container.decode([Segment].self, forKey: .segments)

           if let doubleValue = try? container.decode(Double.self, forKey: .expiryTime) {
               expiryTime = doubleValue
           } else if let stringValue = try? container.decode(String.self, forKey: .expiryTime),
                     let doubleValue = Double(stringValue) {
               expiryTime = doubleValue
           } else {
               expiryTime = 0
           }
       }
     
}
struct Segment: Codable, Identifiable {
    let id: Int
    let originAndDestinationPair: OriginDestinationPair
}

struct OriginDestinationPair: Codable {
    let destination: Location
    let destinationCity: String
    let origin: Location
    let originCity: String
}

struct Location: Codable {
    let code: String
    let displayName: String
    let url: String
}
