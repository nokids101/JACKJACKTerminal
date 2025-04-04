/*
import Foundation

// Scans a folder for all .flac files (recursively)
// Used by FLACReportView to collect files before building the CSV

struct FLACFileScanner {
    static func flacFiles(in folder: URL) -> [URL] {
        let fm = FileManager.default
        guard let enumerator = fm.enumerator(at: folder, includingPropertiesForKeys: nil) else {
            return []
        }

        // Only return files with .flac extension
        return enumerator.compactMap { item in
            guard let url = item as? URL else { return nil }
            return url.pathExtension.lowercased() == "flac" ? url : nil
        }
    }
}
*/
