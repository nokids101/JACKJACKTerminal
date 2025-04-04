import Foundation

// Holds configuration flags used by FLACFileScanner to modify its scanning behavior

struct FLACFileScannerOptions {
    let skipSymlinks: Bool

    // Future options can be added here:
    // let skipExplicit: Bool
    // let scanPlaylistsOnly: Bool

    init(skipSymlinks: Bool = false) {
        self.skipSymlinks = skipSymlinks
    }
}
