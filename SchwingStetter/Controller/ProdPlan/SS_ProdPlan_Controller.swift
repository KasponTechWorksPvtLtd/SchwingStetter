//
//  SS_ProdPlan_Controller.swift
//  SchwingStetter
//
//  Created by TestMac on 16/10/18.
//  Copyright © 2018 TestMac. All rights reserved.
//



import UIKit

protocol updateProductionPlanDelegate: AnyObject {
    func listOfProductionPlan(ary_production_: [ProductionView])
    func errorInProductionList(error_: String)
}

protocol EditProductionPlanDelegate: AnyObject {
    func successResponse(dic_response: EditProductionView)
    func errorResponse(error_: String)
}

protocol ProdPlanPartNumDelegate: AnyObject {
    func successResponse(dic_response: SSProdPlanPartNum)
    func errorResponseProdPlanPrtNo(error_: String)
}

class SS_ProdPlan_Controller: UIViewController {

    weak var delegate: updateProductionPlanDelegate?
    weak var delegate_edit: EditProductionPlanDelegate?
    weak var delegate_prodPlanPrtNo: ProdPlanPartNumDelegate?
    
    
    var ary_producView: [ProductionView]!
    var dic_response: EditProductionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    func  getPartNumber()  {
        methNam = methoName1.cnc_
        postWebService(str_methodName: MethodNames.mia_mixer_partNum.rawValue, str_postParam: [Keys_val.switchcase.rawValue: Keys_val.mia_sc_getmixassprt.rawValue]){
           
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let resObj = try decoder_.decode(SSProdPlanPartNum.self, from: jsonData)
                    self.delegate_prodPlanPrtNo?.successResponse(dic_response: resObj)
                
            }catch (let err_){
                self.delegate_prodPlanPrtNo?.errorResponseProdPlanPrtNo(error_: err_.localizedDescription)
                }
                
            }else {
                    self.delegate_prodPlanPrtNo?.errorResponseProdPlanPrtNo(error_: "Try again later")

                }
            
            
        }
    }
    func getProductionList(fromDate_: String, toDate_: String) {
        
        methNam = methoName1.cnc_
        
        postWebService(str_methodName: MethodNames.production_view.rawValue, str_postParam: [Keys_val.fromdate.rawValue: fromDate_, Keys_val.todate.rawValue: toDate_]){
            print("rawVal:-\($0)")
            guard let ary_dic = $0[Keys_val.message_.rawValue] as? [Dictionary<String, Any>] else {
                self.delegate?.errorInProductionList(error_: "Nodata, try again later")
                return
            }
            
            self.ary_producView = [ProductionView]()
            let decoder_ = JSONDecoder()
            do{
                for item_ in ary_dic {
                    
                    let jsonData = try JSONSerialization.data(withJSONObject: item_, options: [])
                    let prodView = try decoder_.decode(ProductionView.self, from: jsonData)
                    
                    self.ary_producView.append(prodView)
                }
                
                self.delegate?.listOfProductionPlan(ary_production_: self.ary_producView)
            }catch (let err_){
                self.delegate?.errorInProductionList(error_: err_.localizedDescription)
            }
            
            
        }
    }
    
    func getProductionList(partNum: Int, selecDate: String) {
        
        methNam = methoName1.lineRej
        
        postWebService(str_methodName: MethodNames.production_edit.rawValue, str_postParam: [Keys_val.switchcase.rawValue: Keys_val.pp_getList.rawValue, Keys_val.partno_.rawValue: partNum, Keys_val.date_.rawValue: selecDate]){
            print("rawVal:-\($0)")
            guard let ary_dic = $0[Keys_val.message_.rawValue] as? [Dictionary<String, Any>] else {
                self.delegate?.errorInProductionList(error_: "Nodata, try again later")
                return
            }
            
            self.ary_producView = [ProductionView]()
            let decoder_ = JSONDecoder()
            do{
                for item_ in ary_dic {
                    
                    let jsonData = try JSONSerialization.data(withJSONObject: item_, options: [])
                    let prodView = try decoder_.decode(ProductionView.self, from: jsonData)
                    
                    self.ary_producView.append(prodView)
                }
                
                self.delegate?.listOfProductionPlan(ary_production_: self.ary_producView)
            }catch (let err_){
                self.delegate?.errorInProductionList(error_: err_.localizedDescription)
            }
            
            
        }
    }
    
    func updateEditedProductionView(str_priority: String, dic_product: ProductionView) {
       
        //let dicVal = [Keys_val.switchcase.rawValue: Keys_val.edit.rawValue, Keys_val.id_.rawValue: dic_product.id!, Keys_val.workorderno.rawValue: dic_product.workorderNo!, Keys_val.modelno.rawValue: dic_product.mixerModelno!, Keys_val.partno.rawValue: dic_product.partNo!, Keys_val.date_.rawValue: SS_Utility.getCurrentDateAndTime(), Keys_val.priority.rawValue: str_priority] as [String : Any]
        
        let dicVal = [Keys_val.switchcase.rawValue: Keys_val.edit.rawValue, Keys_val.id_.rawValue: dic_product.id!, Keys_val.priority.rawValue: str_priority] as [String : Any]
        
        postWebService(str_methodName: MethodNames.production_edit.rawValue, str_postParam: dicVal){
            print("response:- \($0)")
            
            if !$0.isEmpty {
                let decoder_ = JSONDecoder()
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let prodView = try decoder_.decode(EditProductionView.self, from: jsonData)
                    self.delegate_edit?.successResponse(dic_response: prodView)
                    
                } catch let err_{
                    self.delegate_edit?.errorResponse(error_: err_.localizedDescription)
                }
              

            }else{
                self.delegate_edit?.errorResponse(error_: "Try again later")
            }
            
        }
        
    }
    
    //MARK:-
    
    func  compareTwoDates(from_: String, to_: String) -> Bool {
        let dateFor = DateFormatter()
        dateFor.dateFormat = "yyyy-MM-dd"
        
        let fromDate = dateFor.date(from: from_)
        let toDate = dateFor.date(from: to_)
        
        return fromDate! > toDate!
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class SS_ProdPlan_tableCell: UITableViewCell{
    @IBOutlet weak var lbl_woNum: UILabel!
    @IBOutlet weak var lbl_mav: UILabel!
    @IBOutlet weak var lbl_portNum: UILabel!
    @IBOutlet weak var lbl_priorNum: UILabel!
    @IBOutlet weak var lbl_planSched: UILabel!
     @IBOutlet weak var btn_edit: UIButton!
}
