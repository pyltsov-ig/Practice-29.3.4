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
    let fileName = "customFile.txt"
    let myFileName = "otherfile.txt"
    
    
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
    
    func validateCatalog() -> String? {
        do {
            let objectsInCatalog = try fileManager.contentsOfDirectory(atPath: tempDirectory)
            var list = ""
            let objects = objectsInCatalog
            if objects.count > 0 {
                for i in 0 ..< objects.count {
                    list = list + objects[i] + "\n"
                }
                if objects.first == fileName {
                    print("File WAS found")
                    return objects.first
                } else {
                    print("File NOT found")
                    return nil
                }
            }
        } catch {return nil} //catch let error as NSError {
          //  addressLabel.text = "Error  - \(error)"
        //}
    return nil
    }
    
    @IBAction func checkTmp(_ sender: UIButton) {
        let fileCatalog = validateCatalog() ?? "Nothing"
        addressLabel.text = fileCatalog
    }
    
}

