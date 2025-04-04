
import SwiftUI

struct RunTracklistGenerator: View {
    // Tracks whether the user has clicked "Tracklist Generator"
    @State private var tracklistActive = false

    // Tracks whether the user has selected symlink preference (yes or no)
    @State private var includeSymlinks: Bool? = nil

    var body: some View {
        VStack(spacing: 24) {
            if !tracklistActive {
                // 🔘 Step 1: Initial button to launch the Tracklist Generator
                Button("Tracklist Generator") {
                    tracklistActive = true
                }
                .font(.title2)
                .padding()

            } else if includeSymlinks == nil {
                // 🧠 Step 2: Ask user whether to include symlinks in the scan
                Text("Include symlinks?")
                    .font(.headline)

                HStack(spacing: 32) {
                    // ✅ User chooses YES — include symlinks in scan
                    Button("Yes") {
                        includeSymlinks = true
                        runReport(skipSymlinks: false) // false = do not skip = include symlinks
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.green.opacity(0.2))
                    .cornerRadius(10)

                    // ❌ User chooses NO — skip symlinks in scan
                    Button("No") {
                        includeSymlinks = false
                        runReport(skipSymlinks: true) // true = skip symlinks
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.red.opacity(0.2))
                    .cornerRadius(10)
                }

            } else {
                // 🕒 Step 3: Waiting for scan to finish
                Text("Generating FLAC report...")
            }
        }
        .padding()
    }

    /// Runs the full FLAC report flow based on symlink option selected in UI.
    /// This handles folder picking, scanning, and passes result to the report engine.
    /// - Parameter skipSymlinks: true = skip symlinks, false = include symlinks
    func runReport(skipSymlinks: Bool) {
        // 🛠️ Create options object based on user's choice
        let options = FLACFileScannerOptions(skipSymlinks: skipSymlinks)

        // 📁 Ask user to pick a folder
        guard let folder = InputFolderHandler.getFolder() else {
            print("No folder selected. Aborting.")
            return
        }

        // 🔍 Scan folder using selected options
        let flacFiles = FLACFileScanner.flacFiles(in: folder, options: options)

        // 📄 Pass scanned results into the reporting engine (new overload)
        FLACReportEngine.runReport(from: flacFiles, saveTo: folder)

    }
}

#Preview {
    RunTracklistGenerator()
}
