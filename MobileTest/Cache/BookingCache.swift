import Foundation

final class BookingCache {
    private let cacheKey = "booking_cache"

    func save(_ booking: BookingResponse) {
        if let data = try? JSONEncoder().encode(booking) {
            UserDefaults.standard.set(data, forKey: cacheKey)
        } else {
            print("cache error")
        }
    }

    func load() -> BookingResponse? {
        guard let data = UserDefaults.standard.data(forKey: cacheKey) else { return nil }
        return try? JSONDecoder().decode(BookingResponse.self, from: data)
    }

    func clean() {
        UserDefaults.standard.removeObject(forKey: cacheKey)
    }

}
