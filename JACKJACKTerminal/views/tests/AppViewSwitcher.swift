import SwiftUI

struct AppViewSwitcher: View {
    @State private var selection: String? = nil

    var body: some View {
        if selection == "JACKJACK" {
            ContentView()
        } else if selection == "Tracklist" {
            RunTracklistGenerator()
        } else {
            VStack(spacing: 20) {
                Text("Choose a tool to launch:")
                    .font(.title2)
                    .padding()

                Button("🖥 JACKJACK Terminal") {
                    selection = "JACKJACK"
                }

                Button("📂 Tracklist Generator") {
                    selection = "Tracklist"
                }
            }
            .frame(width: 400, height: 300)
        }
    }
}
