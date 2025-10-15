import SwiftUI

struct BookingListView: View {
    @State private var bookings: [Segment] = []
    @State private var isLoading = false
    let manager = BookingDataManager()

    var body: some View {
        NavigationView {
            List(bookings) { segment in
                VStack(alignment: .leading) {
                Text("\(segment.originAndDestinationPair.origin.displayName) →" +
                     "\(segment.originAndDestinationPair.destination.displayName)")
                        .font(.headline)
                    Text("\(segment.originAndDestinationPair.originCity)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Bookings")
            .refreshable {
                await loadData(force: true)
            }
            .onAppear {
                Task { await loadData(force: false) }
            }
        }
    }

    private func loadData(force: Bool) async {
        isLoading = true
        do {
            let data = try await manager.getBookingData(forceRefresh: force)
            bookings = data.segments
            print("Loaded \(bookings.count) segments")
            data.segments.forEach { segment in
                let origin = segment.originAndDestinationPair.origin.displayName
                let destination = segment.originAndDestinationPair.destination.displayName
                print("Segment #\(segment.id): \(origin) → \(destination)")
            }
        } catch {
            print("Error: \(error)")
        }
        isLoading = false
    }
}
