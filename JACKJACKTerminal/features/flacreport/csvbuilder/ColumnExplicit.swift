// Returns explicit warning ONLY if (E) is found in title or filename

import Foundation

struct ColumnExplicit {
    static func from(cache: TagCache, url: URL) -> String {
        
        // Get title and filename
        let title = cache.get("TITLE").joined(separator: "; ")
        let filename = url.lastPathComponent

        // Show explicit warning only if (E) exists
        if title.contains("(E)") || filename.contains("(E)") {
            return "🔞 Not for minors"
        }

        return ""
    }
}
