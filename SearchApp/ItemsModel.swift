//
//  ItemsModel.swift
//  SearchApp
//
//  Created by Vladislav on 1/22/18.
//  Copyright © 2018 Vladislav. All rights reserved.
//

import Foundation


struct Information: Decodable {
    let items: [Items]
}

struct Items: Decodable
{
    let link: String
}

func getDocumentsURL() -> URL {
    if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        return url
    } else {
        fatalError("Could not retrieve documents directory")
    }
}

func getJSON(message: String){
    
    let jsonUrlString = "https://www.googleapis.com/customsearch/v1?q=\(message)&key=AIzaSyCjJjAkfcCnL9yB26Tm5wkcF05pu-qLc4o&cx=009129419497175488195:6v4gsgduydm"
    guard let url = URL(string: jsonUrlString) else { return }
        do{
          let contentOfURL = try Data(contentsOf: url)
            do{
                let url1 = getDocumentsURL().appendingPathComponent("posts.json")
                try contentOfURL.write(to: url1, options: [])
            } catch {
                fatalError(error.localizedDescription)
            }
        } catch {
        fatalError(error.localizedDescription)
        }
    
    
}


func getPostsFromDisk() -> Data {
    let url = getDocumentsURL().appendingPathComponent("posts.json")
    do {
        let data = try Data(contentsOf: url, options: [])
        return data
    } catch {
        fatalError(error.localizedDescription)
    }
}

func decodable() -> [String]{
    var arrStr: [String] = []
    do{
        let information = try
            JSONDecoder().decode(Information.self, from: getPostsFromDisk())
        
        for items in information.items {
             arrStr.append(items.link)
        }
        
    } catch {

        print("Error serislizing json:")

    }

    return arrStr
}


