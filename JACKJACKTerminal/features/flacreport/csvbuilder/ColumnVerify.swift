import Foundation

// Uses VerifyRunner to test FLAC integrity
// Returns the full message (OK, warning, or error) directly into the CSV

struct ColumnVerify {
    static func from(url: URL) -> String {
        return VerifyRunner.runFLACVerify(url: url)
    }
}




/* should use bellow
struct ColumnVerify {
    static func from(url: URL) -> String {
        let output = VerifyRunner.runFLACVerify(url: url)
        let cleanOutput = output.trimmingCharacters(in: .whitespacesAndNewlines)
        let lower = cleanOutput.lowercased()

        // ✅ If the file is OK, return "✅ OK" (or just "OK")
        if lower.contains("ok") {
            return "✅ OK"  // Or return just "OK" if you don't want the emoji
        }

        // ⚠️ If there's a warning (e.g., MD5 mismatch), return that with a warning emoji
        if lower.contains("md5") || lower.contains("warning") {
            return "⚠️ " + cleanOutput  // Customize the warning message if needed
        }

        // If it's neither "OK" nor a warning, return the clean output (if applicable)
        return cleanOutput
    }
}
*/
