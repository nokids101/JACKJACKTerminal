import Foundation

// FLACReportEngine.swift
// This engine handles the actual writing of the CSV file.
// It receives FLAC files and a save folder path, then builds the metadata report.

struct FLACReportEngine {

    // Main entry point when FLACs are provided + save folder is chosen.
    // This will build and export the CSV to the same folder the user picked.
    // - Parameters:
    //   - flacFiles: An array of FLAC file URLs
    //   - folder: The folder to save the report in (from folder picker)
    static func runReport(from flacFiles: [URL], saveTo folder: URL) {
        // 📄 Build the output path for the CSV inside the chosen folder
        let outputURL = folder.appendingPathComponent("flac_metadata_report.csv")

        // 🧼 Remove old file if it already exists — ensures clean slate each time
        if FileManager.default.fileExists(atPath: outputURL.path) {
            try? FileManager.default.removeItem(at: outputURL)
        }

        // 📝 Try to create the file by writing the header row
        do {
            let header = CreateHeader.headerRow().joined(separator: ",") + "\n"
            try header.write(to: outputURL, atomically: true, encoding: .utf8)

            // ✍️ Open the newly written (created) file so we can add each row now that it exists
            guard let fileHandle = try? FileHandle(forWritingTo: outputURL) else {
                print("❌ Failed to open CSV file for writing.")
                return
            }

            fileHandle.seekToEndOfFile() // 📌 Move cursor to end so we append rows properly

            for file in flacFiles {
                let rawVerifyOutput = VerifyRunner.runFLACVerify(url: file)
                let lower = rawVerifyOutput.lowercased()

                var row: [String]

                if lower.contains("error") || lower.contains("fail") || lower.contains("invalid") {
                    row = [ColumnFilename.from(url: file)] + Array(repeating: "🔴 ERROR 🔴", count: 17)
                } else {
                    let tagCache = TagCache.load(from: file)
                    row = [
                        ColumnFilename.from(url: file),
                        ColumnTitle.from(cache: tagCache),
                        ColumnArtist.from(cache: tagCache),
                        ColumnAlbum.from(cache: tagCache),
                        ColumnTrackNumber.from(cache: tagCache),
                        ColumnLength.from(url: file),
                        ColumnDate.from(cache: tagCache),
                        ColumnAlbumArtist.from(cache: tagCache),
                        ColumnArtists.from(cache: tagCache),
                        ColumnComment.from(cache: tagCache),
                        ColumnFullResolution.from(cache: tagCache),
                        ColumnExplicit.from(cache: tagCache, url: file),
                        ColumnRecordLabel.from(cache: tagCache),
                        ColumnReleaseType.from(cache: tagCache),
                        ColumnTotalTracks.from(cache: tagCache),
                        ColumnFileSpecs.from(url: file),
                        ColumnFilepath.from(url: file),
                        ColumnVerify.from(url: file)
                    ]
                }

                // 🧾 Build final CSV row string and write to file
                let csvLine = row.map { "\"\($0)\"" }.joined(separator: ",") + "\n"
                fileHandle.write(Data(csvLine.utf8))
            }

            // ✅ Done writing!
            fileHandle.closeFile()
            print("✅ FLAC metadata report saved at: \(outputURL.path)")

        } catch {
            print("❌ Failed to write CSV: \(error.localizedDescription)")
        }
    }
}



