import Foundation
import Commander
import Files

let main = command(
    Option<String>("output_path", default: "Assets.xcassets", description: "output path"),
    Option<String>("json_path", default: ".", description: "parse json files")
) { (outputPath, jsonPath) in
    guard let folder = try? File(path: jsonPath), let data = try? folder.read() else {
        print("not found json file")
        return
    }

    do {
        let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as! [[String: Any]]
        let parser = ColorAssetFileCreator(json: json, outputPath: outputPath)
        do {
            try parser.write()
        } catch {
            print(error.localizedDescription)
        }
    } catch {
        print(error.localizedDescription)
    }
}
main.run()
