import Foundation
import Files

enum CreatorError: Error {
    case invalidFormat
}

enum PathExtension: String {
    case swift
    case xcassets
}

struct ColorAssetFileCreator: FileCreatable {
    private let json: [[String: Any]]
    private let outputPath: String
    init(json: [[String: Any]], outputPath: String) {
        self.json = json
        self.outputPath = outputPath
    }
    
    func write() throws {
        let urlPath = URL(fileURLWithPath: outputPath)
        let path = urlPath.deletingLastPathComponent().absoluteString
        let _path = path.replacingOccurrences(of: "file://", with: "")
        let folder = try Folder(path: _path)
        let fileName = urlPath.lastPathComponent
        let rootFolder = try folder.createSubfolderIfNeeded(withName: fileName)
        let rootFile = try rootFolder.createFileIfNeeded(withName: "Contents.json", contents: nil)
        try rootFile.write("""
{
  "info" : {
    "version" : 1,
    "author" : "xcode"
  }
}
""")
        let array = json.compactMap({ JSONObject(dic: $0) })
        array.forEach { object in
            if let newFolder = try? rootFolder.createSubfolder(named: object.colorName + ".colorset"),
                let newFile = try? newFolder.createFileIfNeeded(withName: "Contents.json", contents: nil) {
                var texts: [String] = []
                if let result = ColorConverter(hexString: object.hex).convert() {
                    let e = ColorElement(red: result.red,
                                      green: result.green,
                                      blue: result.blue,
                                      alpha: result.alpha, appearanceTyoe: nil).element
                    texts.append(e)
                }
                
                if let hex = object.hex_light_color, let result = ColorConverter(hexString: hex).convert() {
                    let e = ColorElement(red: result.red,
                                         green: result.green,
                                         blue: result.blue,
                                         alpha: result.alpha, appearanceTyoe: .light).element
                    texts.append(e)
                }
                
                if let hex = object.hex_dark_color, let result = ColorConverter(hexString: hex).convert() {
                    let e = ColorElement(red: result.red,
                                         green: result.green,
                                         blue: result.blue,
                                         alpha: result.alpha, appearanceTyoe: .dark).element
                    texts.append(e)
                }
                
                let text = texts.joined(separator: ",\n")
                let data = """
{
  "colors" : [
    \(text)
  ],
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
                }
"""
                _ = try? newFile.write(data)
            }
        }
    }
}

