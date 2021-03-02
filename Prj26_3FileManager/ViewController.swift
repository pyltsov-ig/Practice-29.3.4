//
//  ViewController.swift
//  Prj26_3FileManager
//
//  Created by ИГОРЬ on 28/02/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var addressLabel: UILabel!
    
    let fileManager = FileManager()
    let tempDirectory = NSTemporaryDirectory()
    //let docsDirectory =
    let fileName = "customFile.txt"
    let folderName = "CustomFolder"
    let myFileName = "otherfile.txt"
    var folderPath = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "Info", ofType: "plist")
        guard let uPath = path else {return}
        addressLabel.text = uPath
    }

    @IBAction func createFileBtnPressed(_ sender: UIButton) {
        let filePath = (tempDirectory as NSString).appendingPathComponent(fileName)
        let fileContent = "Some Text Here. Good. Good!!!"
        
        do {
            try fileContent.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
            addressLabel.text = "File was successfully created \n \(filePath)"
        } catch let error as NSError {
            addressLabel.text = "Error  - \(error)"
        }
    }
    
    
    @IBAction func createMyFileBtnPressed(_ sender: UIButton) {
        let filePath = (tempDirectory as NSString).appendingPathComponent(myFileName)
        let fileContent = "А этот файл будет по-русски!"
        
        do {
            try fileContent.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
            addressLabel.text = "Файл успешно создан \n \(filePath)"
        } catch let error as NSError {
            addressLabel.text = "Ошибка - \(error)"
        }
        
    }
    
    // метод был изменен так чтобы выводил список файоа из каталога
    func validateCatalog() -> String? {
        do {
            let objectsInCatalog = try fileManager.contentsOfDirectory(atPath: tempDirectory)
            var list = ""
            let objects = objectsInCatalog
            if objects.count > 0 {
                
                for i in 0 ..< objects.count {
                    list = list + objects[i] + "\n"
                }
                return list
            } else {
                print("File NOT found")
                return nil
                }
            } catch {return nil}
        //catch let error as NSError {  
          //  addressLabel.text = "Error  - \(error)"
        //}
}
    
    @IBAction func checkTmp(_ sender: UIButton) {
        let fileCatalog = validateCatalog() ?? "Nothing"
        addressLabel.text = fileCatalog
    }
    
    @IBAction func createFolderBtnPressed(_ sender: UIButton) {
        let docsFolderPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        let logPath = docsFolderPath.appendingPathComponent(folderName)
        guard let unwrLogPath = logPath else {return}
        do {
            try FileManager.default.createDirectory(atPath: unwrLogPath.path, withIntermediateDirectories: true, attributes: nil)
            addressLabel.text = "\(unwrLogPath)"
        } catch let error as NSError {
            addressLabel.text = "Can't create a directory, \(error)"
        }
    }
    
    @IBAction func checkFolder(_ sender: UIButton) {
        let directories : [String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        if directories.count > 0 {
            let directory  = directories[0] //дирктория с документами
            folderPath = directory.appendingFormat("/" + fileName)
            print("Local path = \(folderPath)")
        } else {
            print("Could not fond local directory for this folder")
        }
        // проверка, есть ли файл
        if fileManager.fileExists(atPath: folderPath) {
            addressLabel.text = "Folder exists  - \(folderPath)"
        } else {
            addressLabel.text = "Folder does not exists"
        }
    }
    
    
    @IBAction func readFile(_ sender: UIButton) {
        let directoryWithFile = myFileName
        let path = (tempDirectory as NSString).appendingPathComponent(directoryWithFile)
        do {
           let contentsOfFile = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue)
            addressLabel.text = String(contentsOfFile)
        } catch let error as NSError {
            addressLabel.text = "Иррор \(error)"
        }
    }
    
    @IBAction func writeToFile(_ sender: UIButton) {
        let someText = "Bonjour, fichier !!! Pouvez-vous me lire?"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            do {
                try someText.write(to: fileURL, atomically: false, encoding: .utf8)
                addressLabel.text = "'\(someText)' added to '\(fileName)'"
            } catch {
                addressLabel.text = "Unable to write"
            }
        }
    }
    @IBAction func readFromWritedFile(_ sender: UIButton) {
        
        //let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first

        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fullPath = documentDirectory?.appendingPathComponent(fileName)
        do {
            let contentsOfFile = try NSString(contentsOfFile: fullPath?.path ?? "", encoding: String.Encoding.utf8.rawValue)
            addressLabel.text = contentsOfFile as String
        } catch let error as NSError {
            addressLabel.text = "Error  \(error)"
        }
        
        
        
        
    }
    
}

