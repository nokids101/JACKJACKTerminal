import Foundation

// Combines bit depth and sample rate into one column (e.g., "24/48000")
struct ColumnFileSpecs {
    static func from(url: URL) -> String {
        // Ask Terminal: what is the bit depth?
        guard let bit = FLACMetadataExtractor.getRaw("--show-bps", from: url),
              !bit.isEmpty else {
            return ""
        }

        // Ask Terminal: what is the sample rate?
        guard let rate = FLACMetadataExtractor.getRaw("--show-sample-rate", from: url),
              !rate.isEmpty else {
            return ""
        }

        // ✅ Clean return string (no Optional(...))
        return "\(bit)/\(rate)"
    }
}
