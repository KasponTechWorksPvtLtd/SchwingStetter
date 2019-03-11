//
//  SS_WebService_GET.swift
//  SchwingStetter
//
//  Created by TestMac on 08/10/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import Foundation

//protocol ResponseObjectDelegate_GET: class {
//    func responseObject(dic_val: [String: Any])
//}
/*

 
 */
func getWebservice(str_methodName: String, callBack: @escaping ([String: Any]) -> Void) {
   // weak var delegate: ResponseObjectDelegate_GET?
    
    
    let url = URL(string: str_methodName)
    let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
        
        guard error == nil else {
            print("returning error")
            return
        }
        
        guard let content = data else {
            print("not returning data")
            return
        }
        
        guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
            print("Not containing JSON")
            return
        }
       // if let array = json["companies"] as? [String] { }
        
        
        DispatchQueue.main.async {
            callBack(json)
         
            //delegate?.responseObject(dic_val: json)
        }
    }
    
    task.resume()

    
}
