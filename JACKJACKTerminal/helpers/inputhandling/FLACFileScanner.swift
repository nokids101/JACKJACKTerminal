import Foundation

// Scans a folder for all .flac files (recursively)
// Supports scan options such as skipping symlinks
// Used by FLACReportView to collect files before building the CSV

struct FLACFileScanner {

    // Scans the given folder and returns an array of .flac file URLs
    // - Parameters:
    // - folder: The folder to scan
    // - options: Optional scan options (e.g. skipSymlinks)
    // - Returns: An array of FLAC file URLs, filtered according to the options
    static func flacFiles(in folder: URL, options: FLACFileScannerOptions = FLACFileScannerOptions()) -> [URL] {
        let fm = FileManager.default

        // Only request symlink info if we might use it (performance boost)
        let propertyKeys: [URLResourceKey] = options.skipSymlinks ? [.isSymbolicLinkKey] : []

        guard let enumerator = fm.enumerator(at: folder, includingPropertiesForKeys: propertyKeys) else {
            return []
        }

        return enumerator.compactMap { item in
            guard let url = item as? URL else { return nil }

            // Skip symlinks if the user requested it
            if options.skipSymlinks {
                let isSymlink = (try? url.resourceValues(forKeys: [.isSymbolicLinkKey]).isSymbolicLink) ?? false
                if isSymlink { return nil }
            }

            // Only return files with a .flac extension
            return url.pathExtension.lowercased() == "flac" ? url : nil
        }
    }
}
