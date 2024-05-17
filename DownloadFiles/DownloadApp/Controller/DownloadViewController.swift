//
//  ViewController.swift
//  downloadFiles
//
//  Created by Tejashree on 23/03/19.
//  Copyright © 2019 Tejashree. All rights reserved.
//

import UIKit

class DownloadViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,URLSessionDownloadDelegate {
    
    
    @IBOutlet weak var urlEntered: UITextField!
    @IBOutlet weak var downloadTable: UITableView!
    var downloadQueue = [String : Float]()
    var downloadURLArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "Download Files"

        downloadTable.tableFooterView = UIView()
        downloadTable.delegate = self
        downloadTable.dataSource = self
    }

    @IBAction func downloadButtonTapped(_ sender: Any) {
        
        guard let urlString = urlEntered.text else{
            // pop error message
            popAlertWithTitle(title: errorMessage(passedEnum: projectError.isEmpty))
            return
        }
        
        if urlString != ""{
            if UIApplication.shared.canOpenURL(URL(string: urlString)!){
                downloadURLArray.append(urlString)
                downloadQueue[urlString] = 0.0

                DispatchQueue.global().async {
                    self.beginDownloadingFile(urlString: urlString)
                }
            }else{
                popAlertWithTitle(title: errorMessage(passedEnum: projectError.cannotOpen))
                return
            }
            urlEntered.text = ""
            downloadTable.reloadData()
            
        }else{
            popAlertWithTitle(title: errorMessage(passedEnum: projectError.isEmpty))
        }
    }
    
    //MARK: Begin downloading of File
    func beginDownloadingFile(urlString :String){
        
        
        let operatioQ = OperationQueue()
        let urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: operatioQ)
        guard let url = URL(string: urlString) else{
            return
        }
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
        
    }
    
    
    //MARK: URLSessionDownloadDelegate Methods to Track Downloading
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        // Create destination URL
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
        let destinationFileUrl = documentsUrl.appendingPathComponent("\(downloadURLArray.firstIndex(of: ((downloadTask.currentRequest?.debugDescription)!)))")
        do {
            if (FileManager.default.fileExists(atPath: destinationFileUrl.path)){
                try FileManager.default.removeItem(at: destinationFileUrl)
                try FileManager.default.moveItem(at: location, to: destinationFileUrl)
            }else{
                try FileManager.default.moveItem(at: location, to: destinationFileUrl)
            }
        } catch (let writeError) {
            print("Error creating a file \(destinationFileUrl) : \(writeError)")
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {

        DispatchQueue.main.async {
            
            self.downloadQueue[(downloadTask.currentRequest?.description)!] = (Float(totalBytesWritten)/Float(totalBytesExpectedToWrite))
            self.downloadTable.reloadData()
        }
    }

    //MARK: Table View Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return downloadURLArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = downloadTable.dequeueReusableCell(withIdentifier: "downloadCell", for: indexPath) as! DownloadTableViewCell
        cell.urlLabel.text = downloadURLArray[indexPath.row]
        cell.downloadPercent.text = "\(String(Int(self.downloadQueue[downloadURLArray[indexPath.row]]! * 100)))%"
        cell.downloadProgress.progress = self.downloadQueue[downloadURLArray[indexPath.row]]!
        
        return cell
    }
    
    
}

