import Foundation

final class DataService {
    func fetchBookings() async throws -> BookingResponse {
        let data = try Data(contentsOf: Bundle.main.url(forResource: "booking", withExtension: "json")!)
        return try JSONDecoder().decode(BookingResponse.self, from: data)
    }
}
