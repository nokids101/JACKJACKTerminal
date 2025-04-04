import Foundation

// Extracts the filename from the file URL
struct ColumnFilename {
    static func from(url: URL) -> String {
        return url.lastPathComponent
    }
}