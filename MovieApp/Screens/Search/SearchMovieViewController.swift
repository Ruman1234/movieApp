//
//  SearchMovieViewController.swift
//  MovieApp
//
//  Created by Ruman on 13/05/2022.
//

import UIKit
import RxSwift
import RxCocoa
import DropDown

class SearchMovieViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var MovieTableView: UITableView!
    var viewModel : SearchMovieViewProtocol?
    var tableData : [MovieResultsArray]?
    var searchTask: DispatchWorkItem?
    
    private let bag = DisposeBag()
    private let dropDown = DropDown()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchView()
    }
    
    private func setupSearchView(){
        setupTableView()
//        searchBar.delegate = self
        ssetupViewModel()
        dropDown.anchorView = searchBar
        setupSearchBarReactive()
    }
    
    private func setupSearchBarReactive(){
        
        searchBar
            .rx.text
            .orEmpty
            .debounce(.seconds(Int(0.15)), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [unowned self] query in
                viewModel?.getMoviesData(bySearch: query)
            })
            .disposed(by: bag)
        searchBar.rx.textDidEndEditing
            .subscribe(onNext: { [unowned self] query in
                dropDown.dataSource = self.viewModel?.getSearchsFromDB() ?? [""]
                if (self.viewModel?.getSearchsFromDB()?.count ?? 0) > 0 {
                    self.dropDown.show()
                }
                print(self.viewModel?.getSearchsFromDB()?.count ?? 0)
            })
            .disposed(by: bag)
        
        searchBar.rx.searchButtonClicked.subscribe { [self] searchPressed in
            viewModel?.saveSearchesToDB(str: searchBar.text ?? "")
            view.endEditing(true)
        } .disposed(by: bag)
        
        setupDropDown()
    }

    private func setupDropDown(){
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.searchBar.text = item
        }
    }
    
    private func setupTableView(){
        MovieTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        MovieTableView.delegate = self
        MovieTableView.dataSource = self
    }
    
    private func ssetupViewModel(){
        viewModel = SearchMovieViewModel(delegate: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
   
}

extension SearchMovieViewController:MovieHomeProtocols{
    func movieDataProvider(_ movieData: [MovieResultsArray]) {
        tableData = movieData
        self.MovieTableView.reloadData()
    }
    func showError(errorDesc: String) {
        self.createAlert(title: "Alert!!!", message: errorDesc)
    }
}

extension SearchMovieViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = tableData?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        if let cellData = index{
            cell.setupCell(data: cellData)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 121
    }
}
/*
extension SearchMovieViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        DispatchQueue.main.async { [self] in
            viewModel?.getMoviesData(bySearch: searchText)
        }

        var searchTask: DispatchWorkItem?


        // then in your search bar update method

        // Cancel previous task if any
        self.searchTask?.cancel()

        // Replace previous task with a new one
        let task = DispatchWorkItem { [ self] in
            viewModel?.getMoviesData(bySearch: searchText)
        }
        self.searchTask = task

        // Execute task in 0.75 seconds (if not cancelled !)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.15, execute: task)
    }
}
*/
