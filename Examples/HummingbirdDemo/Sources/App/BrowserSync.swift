import Foundation

#if DEBUG
func browserSyncReload() {
    let p = Process()
    p.executableURL = URL(string: "file:///bin/sh")
    p.arguments = ["-c", "browser-sync reload"]
    do {
        try p.run()
    } catch {
        print("Could not auto-reload: \(error)")
    }
}
#endif
