import Foundation

// Returns the full path of the file
struct ColumnFilepath {
    static func from(url: URL) -> String {
        return url.path
    }
}