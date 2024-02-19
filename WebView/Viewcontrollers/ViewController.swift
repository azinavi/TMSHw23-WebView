//
//  ViewController.swift
//  WebView
//
//  Created by azinavi on 14/2/24.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var array: [String] = []
    
    var searchTextField = UITextField()
    var webView = WKWebView()
    var searchButton = UIButton(type: .system)
    var bookmarksButton = UIButton(type: .system)
    var addBookmarkButton = UIButton(type: .system)
    var backButton = UIButton(type: .system)
    var forwardButton = UIButton(type: .system)
    var reloadButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSuperView()
        setupBookmarkButton()
        setupSearchTextField()
        setupWebView()
        setupAddBookmarkButton()
        setupSearchButton()
        setupReloadButton()
        setupForwardButton()
        setupBackButton()
        
    }
    
    private func setupSuperView() {
        title = "Поиск"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        view.backgroundColor =  .black

    }
    
    func setupBackButton() {
        backButton.setTitle("<", for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        backButton.tintColor = .systemBlue
        backButton.layer.borderColor = UIColor.blue.cgColor
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        view.addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.bottomAnchor.constraint(equalTo: webView.topAnchor, constant: -7),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.trailingAnchor.constraint(equalTo: forwardButton.leadingAnchor, constant: 5),
            backButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupForwardButton() {
        
        forwardButton.setTitle(">", for: .normal)
        forwardButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        forwardButton.tintColor = .systemBlue
        forwardButton.layer.borderColor = UIColor.blue.cgColor
        forwardButton.addTarget(self, action: #selector(goForward), for: .touchUpInside)
        
        view.addSubview(forwardButton)
        
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forwardButton.bottomAnchor.constraint(equalTo: webView.topAnchor, constant: -7),
            forwardButton.widthAnchor.constraint(equalToConstant: 30),
            forwardButton.trailingAnchor.constraint(equalTo: reloadButton.leadingAnchor, constant: 10),
            forwardButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupReloadButton() {
        reloadButton.setTitle("⟳", for: .normal)
        reloadButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        reloadButton.tintColor = .systemBlue
        reloadButton.layer.borderColor = UIColor.blue.cgColor
        reloadButton.addTarget(self, action: #selector(reload), for: .touchUpInside)
        
        view.addSubview(reloadButton)
        
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reloadButton.bottomAnchor.constraint(equalTo: webView.topAnchor, constant: -9),
            reloadButton.widthAnchor.constraint(equalToConstant: 40),
            reloadButton.trailingAnchor.constraint(equalTo: searchTextField.leadingAnchor, constant: 0),
            reloadButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupSearchTextField() {
        searchTextField.delegate = self
        searchTextField.placeholder = "Введите URL адрес"
        searchTextField.textColor = .blue
        searchTextField.textAlignment = .center
        searchTextField.backgroundColor = .white
        searchTextField.layer.cornerRadius = 10
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.borderColor = UIColor.blue.cgColor
        
        view.addSubview(searchTextField)
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: bookmarksButton.bottomAnchor, constant: 5),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            searchTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func shakeTextField() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        
        let fromPoint = CGPoint(x: searchTextField.center.x - 10, y: searchTextField.center.y)
        let toPoint = CGPoint(x: searchTextField.center.x + 10, y: searchTextField.center.y)
        
        animation.fromValue = NSValue(cgPoint: fromPoint)
        animation.toValue = NSValue(cgPoint: toPoint)
        
        searchTextField.layer.add(animation, forKey: "position")
    }
    
    private func setupWebView() {
        let url = URL(string: "http://google.com/")
        let request = URLRequest(url: url!)
        self.webView.navigationDelegate = self
        self.webView.load(request)
        
        view.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 5),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            webView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    func setUrl(url: String) -> String {
        return url
    }
    
    private func setupAddBookmarkButton() {
        addBookmarkButton.setTitle("+", for: .normal)
        addBookmarkButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        addBookmarkButton.tintColor = .systemBlue
        addBookmarkButton.layer.borderColor = UIColor.blue.cgColor
        addBookmarkButton.addTarget(self, action: #selector(addBookmark), for: .touchUpInside)
        
        view.addSubview(addBookmarkButton)
        
        addBookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addBookmarkButton.bottomAnchor.constraint(equalTo: webView.topAnchor, constant: -7),
            addBookmarkButton.widthAnchor.constraint(equalToConstant: 30),
            addBookmarkButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            addBookmarkButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    @objc func addBookmark() {
        guard let url = searchTextField.text else { return }
        if url.count > 0 {
            array.append("https://www." + url)
        }
       
    }
    
    private func setupSearchButton() {
        searchButton.setTitle("⌕", for: .normal)
        searchButton.titleLabel?.font = UIFont.systemFont(ofSize: 45)
        searchButton.tintColor = .white
        searchButton.addTarget(self, action: #selector(searchURL), for: .touchUpInside)
        
        view.addSubview(searchButton)
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButton.bottomAnchor.constraint(equalTo: webView.topAnchor, constant: -5),
            searchButton.widthAnchor.constraint(equalToConstant: 30),
            searchButton.trailingAnchor.constraint(equalTo: addBookmarkButton.leadingAnchor, constant: -1),
            searchButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    @objc func searchURL() {
        if (searchTextField.text!.count <= 0) {
            shakeTextField()
            searchTextField.layer.borderColor = UIColor.red.cgColor
            searchTextField.layer.borderWidth = 1.5
        } else {
            searchTextField.layer.borderColor = UIColor.green.cgColor
            let urlFromTextfield = searchTextField.text
            if !((urlFromTextfield!.contains("."))) {
                shakeTextField()
                searchTextField.layer.borderColor = UIColor.red.cgColor
                searchTextField.layer.borderWidth = 1.5
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
    
    private func setupBookmarkButton() {
        bookmarksButton.setTitle("Посмотреть историю", for: .normal)
        bookmarksButton.tintColor = .white
        bookmarksButton.layer.cornerRadius = 10
        bookmarksButton.layer.borderWidth = 1
        bookmarksButton.layer.borderColor = UIColor.blue.cgColor
        bookmarksButton.backgroundColor = .systemBlue
        bookmarksButton.addTarget(self, action: #selector(goToBookmarks), for: .touchUpInside)
        
        view.addSubview(bookmarksButton)
        
        bookmarksButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookmarksButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bookmarksButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            bookmarksButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    //MARK: Actions
    @objc func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @objc func goForward() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @objc func reload() {
        webView.reload()
    }
    
    @objc func goToBookmarks() {
        let boormarkVC = Bookmarks()
        boormarkVC.array = array
        
        self.navigationController?.pushViewController(boormarkVC, animated: false)
    }
}
