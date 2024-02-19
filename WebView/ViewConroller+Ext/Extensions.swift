//
//  Extensions.swift
//  WebView
//
//  Created by azinavi on 16/2/24.
//

import UIKit

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField == searchTextField) {
            return true
        } else {
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.text!.count <= 0) {
            shakeTextField()
            textField.layer.borderColor = UIColor.red.cgColor
            textField.layer.borderWidth = 1.5
        } else {
            textField.layer.borderColor = UIColor.green.cgColor
            let urlFromTextfield = searchTextField.text
            if !((urlFromTextfield!.contains("."))) {
                shakeTextField()
                textField.layer.borderColor = UIColor.red.cgColor
                textField.layer.borderWidth = 1.5
            }
            if !((urlFromTextfield!.contains("https://www."))) {
                let url = URL(string: "https://www." + setUrl(url: searchTextField.text!)) ?? URL(string: "http://google.com/")
                let request = URLRequest(url: url!)
                self.webView.navigationDelegate = self
                self.webView.load(request)
            } else {
                let url = URL(string: setUrl(url: searchTextField.text!)) ?? URL(string: "http://google.com/")
                let request = URLRequest(url: url!)
                self.webView.navigationDelegate = self
                self.webView.load(request)
            }
        }
    }
}

extension Bookmarks: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LinkCellTableViewCell", for: indexPath) as! LinkCellTableViewCell
        cell.configure(titleText: array[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath)")
        let storyboard = UIStoryboard(name: "FAQScreen", bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "FAQScreen") as! FAQViewController
        
        vc.modalPresentationStyle = .fullScreen
        vc.urlSite = array[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

