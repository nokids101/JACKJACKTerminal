import Foundation

// This column calculates the duration of a FLAC file in seconds
// by dividing total samples by the sample rate (samples per second)
struct ColumnLength {
    static func from(url: URL) -> String {

        // 🔍 Attempt to extract total samples as a raw string (e.g., "9541123")
        // Ask Terminal: how many samples are in this file?
        guard
            let samplesStr = FLACMetadataExtractor.getRaw("--show-total-samples", from: url),
            
            // 🔍 Attempt to extract sample rate as a raw string (e.g., "48000")
            // Ask Terminal: what is the sample rate (samples per second)?
            let rateStr = FLACMetadataExtractor.getRaw("--show-sample-rate", from: url),
            
            // 🧠 Convert sample count string to a Double (fail-safe parse) Converts string into actual numbers (Double = allows decimals)

            let samples = Double(samplesStr),
            
            // 🧠 Convert rate string to a Double (fail-safe parse) Converts string into actual numbers (Double = allows decimals)
            let rate = Double(rateStr)
        else {
            // ❌ If any of the above fail (e.g., missing data), return empty cell
            return ""
        }

        // 🛑 Safety check: avoid division by 0 which would crash the program
        guard rate != 0 else {
            return ""
        }

        // ✅ Calculate duration: total samples / samples per second = seconds
        // Format it to 2 decimal places (e.g., "193.42")
        return String(format: "%.2f", samples / rate)
    }
}
