//
//  WeatherViewController.swift
//  downloadFiles
//
//  Created by Tejashree on 24/03/19.
//  Copyright © 2019 Tejashree. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {

    @IBOutlet weak var citySearchBar: UISearchBar!
    @IBOutlet weak var cityWeatherTable: UITableView!
    var citiesWeatherArray = [WeatherModel]()
    let dataCache = NSCache<AnyObject, AnyObject>()

    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        self.navigationItem.title = "City Weather"

        cityWeatherTable.tableFooterView = UIView()
        cityWeatherTable.delegate = self
        cityWeatherTable.dataSource = self
        
        citySearchBar.delegate = self
    }
    
    //MARK: Search Bar Methods Implementation
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Search Button pressed
        guard var citySearched = citySearchBar.text else{return}
        
        if citySearched != ""{
            getResponseAndDisplay(citySearched: citySearched)

        }else{
            popAlertWithTitle(title: errorMessage(passedEnum: .isEmpty))
        }
    }

    func getResponseAndDisplay(citySearched : String) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(citySearched)&appid=cba0b0173d9f6b916153843297cf1770"
        
        Request.getResponseJSON(urlString: urlString, targetViewController: self) { (responseObject, error) in
            if responseObject != nil{
                if (responseObject?.allKeys.count)! > 2{
                    self.citiesWeatherArray.insert(WeatherModel(res: responseObject!), at: 0)
                    DispatchQueue.main.async {
                        self.dataCache.setObject(self.citiesWeatherArray.last! as AnyObject, forKey: citySearched as AnyObject)
                        self.citySearchBar.text = ""
                        self.cityWeatherTable.reloadData()
                        
                    }
                }else{
                    DispatchQueue.main.async {
                        self.popAlertWithTitle(title: responseObject?.value(forKey: "message") as! String)
                    }
                }
            }
        }
    }
    
    //MARK: Table View DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.citiesWeatherArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cityWeatherTable.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! weatherTableViewCell
        let data = self.citiesWeatherArray[indexPath.row]
        cell.cityLabel.text = data.name
        cell.cityDetails.text = "\(data.name!) , \(data.country!)"
        cell.temperatureLabel.text = String(format: "%.0f", Float(truncating: data.temp) - 273.15) + "°C"
        cell.temperatureDetails.text = String(format: "%.0f", Float(truncating: data.temp_min) - 273.15) + "°C - " + String(format: "%.0f", Float(truncating: data.temp_max) - 273.15) + "°C"
        cell.weatherDetails.text = "Humidity : \(data.humidity!)"
        cell.weatherSymbol.downloaded(from: "http://openweathermap.org/img/w/\((data.weather.icon)!).png")
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
