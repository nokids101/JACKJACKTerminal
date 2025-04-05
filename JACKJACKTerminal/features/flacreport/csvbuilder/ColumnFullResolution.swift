import Foundation

struct ColumnFullResolution {
    static func from(cache: TagCache) -> String {
        let res = cache.get("COMMENT") //  Begin emoji tagging for Lossless/Lossy/Other

        switch res {
        case ["Lossless"]:
            return "✅ Lossless"
        case ["Lossy"]:
            return "❌ Lossy"
        default:
            return "⚠️ Unknown"
        }
    }
}

/* Another more compact option again
 import Foundation

/// Strict tag validator for "COMMENT" — only accepts a single value with exact match.
/// ✅ = "Lossless", ❌ = "Lossy", ⚠️ = anything else (multiple, misspelled, empty, etc)
struct ColumnFullResolution {
    static func from(url: URL) -> String {
        let values = FLACMetadataExtractor.getRawTagValues("COMMENT", from: url)
 
        // Expression (compact switch block) compared to current classic switch block which is the more modern and neater if/else logic bloc.
        return switch values {
        case ["Lossless"]: "✅ Lossless"
        case ["Lossy"]: "❌ Lossy"
        default: "⚠️ Unknown"
        }
    }
}
*/
