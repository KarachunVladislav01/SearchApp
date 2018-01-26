//
//  ViewController.swift
//  SearchApp
//
//  Created by Vladislav on 1/22/18.
//  Copyright © 2018 Vladislav. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var message: UITextField!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var errLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let global = DispatchQueue(label: "com.Vladislav.searchApp.Queue",qos: .utility)
    
    let apiOperation = OperationQueue()
    var flag = 0
    var stopDispatch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiOperation.maxConcurrentOperationCount = 1

        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        stopButton.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if flag == 0 { return 0 } else { return decodable().count }
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchResultTableViewCell
        
        
        if flag == 0 { } else {
            cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
            let links = decodable()
            cell.resultLinkLabel.text = links[indexPath.row]
        }
        return cell
    }
    public func reloadViev(str: String){
        self.errLabel.text = "\(str)"
        self.message.text = ""
        self.searchButton.isHidden = false
        self.stopButton.isHidden = true
        self.activityIndicator.stopAnimating()
    }
    
        @IBAction func searchButton(_ sender: Any) {
            self.errLabel.text = ""
            searchButton.isHidden = true
            stopButton.isHidden = false
            
            if self.message.text! != ""{
                activityIndicator.startAnimating()
                
                let message = String(self.message.text!)
                    if stopDispatch == false{
                        global.async {
                            getJSON(message: message)
                        }
                        
                    }
                global.async
                    {
                        if self.stopDispatch == false{
                        _ = decodable()
                        self.flag = 1
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                self.reloadViev(str: "")
                            }
                        }
                        else {
                            self.stopDispatch = false
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                self.reloadViev(str: "")
                                
                            }
                                }
                    }
            }
            else {
                reloadViev(str: "Enter the query")
            }
    }

    @IBAction func stopButton(_ sender: Any) {
        global.suspend()
        stopDispatch = true
        self.flag = 0
        global.resume()
    }
    
}



