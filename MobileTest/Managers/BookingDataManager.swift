import Foundation

final class BookingDataManager {
    private let service = DataService()
    private let cache = BookingCache()
    
        func getBookingData(forceRefresh: Bool = false) async throws -> BookingResponse {
        if !forceRefresh,
           let cached = cache.load(),
           isCacheValid(cached) {
            print("使用缓存数据")
            return cached
        }
        // 否则获取新数据
        let newData = try await service.fetchBookings()
        cache.save(newData)
        print("使用新数据")
        return newData
    }
    
    func isCacheValid(_ booking: BookingResponse) -> Bool {
        let now = Date().timeIntervalSince1970
        return now < booking.expiryTime
    }
    
}
