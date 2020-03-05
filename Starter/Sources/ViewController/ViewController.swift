//
//  ViewController.swift
//  The MIT License (MIT)
//
//  Copyright (c) 2020 Kyujin Kim
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Moya
import RxMoya

final class ViewController: UIViewController {
    private let searchBar: UISearchBar = UISearchBar()
    private let tableView: UITableView = UITableView()
    
    private let usersSubject: BehaviorSubject<[GithubUser]> = BehaviorSubject<[GithubUser]>(value: [])
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    private func initialize() {
        addSubview()
        layout()
        style()
        behavior()
    }
    
    private func addSubview() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    private func layout() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func style() {
        title = "Moya-Demo-Starter"
        navigationController?.navigationBar.isTranslucent = false
    
        tableView.rowHeight = 80.0
        tableView.register(SearchUserTableViewCell.self, forCellReuseIdentifier: "SearchUserTableViewCell")
    }
    
    private func behavior() {
        usersSubject.asObservable()
            .bind(to: tableView.rx.items) { tableView, row, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: "SearchUserTableViewCell", for: IndexPath(row: row, section: 0))
                if let userCell = cell as? SearchUserTableViewCell {
                    userCell.configuration(imageUrl: item.avatar_url, userName: item.login)
                }
                return cell
            }
            .disposed(by: disposeBag)
        
        searchBar.rx.text
            .orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] query in
                self?.searchWithRx(query: query)
            })
            .disposed(by: disposeBag)
        
        searchBar.rx
            .searchButtonClicked
            .subscribe(onNext: { [weak self] in
                self?.searchBar.resignFirstResponder()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - API call & response handling
extension ViewController {
    private func searchWithSwift(query: String) {
        // Need implement.
    }
    
    private func searchWithRx(query: String) {
        // Need implement.
    }
    
    private func handleSuccessResponse(_ response: Response) {
        do {
            let searchResult = try JSONDecoder().decode(GithubSearchUser.self, from: response.data)
            usersSubject.onNext(searchResult.items)
        } catch {
            print(error.localizedDescription)
        }
    }
}
