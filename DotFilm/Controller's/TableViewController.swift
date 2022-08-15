//
//  TableViewController.swift
//  DotFilm
//
//  Created by Nikita Chekmarev on 06.07.2022.
//

import UIKit

class TableViewController: UITableViewController {

    
    @IBOutlet var filmTableView: UITableView!
   
    var filmData: [Doc] = []
    var pages: Int?
    var currentPages = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        filmTableView.dataSource = self
        filmTableView.delegate = self
        setData(url: Parametrs.filmsUrl)
    }
    private func setParameters() -> [String:String]{
        let param = ["page": "\(currentPages)","token": Parametrs.token]
        return param
    }
    func setPagination(){
        if currentPages <= pages ?? 1{
            currentPages += 1
            setData(url: Parametrs.filmsUrl)
        }
    }
    
    private func setData(url: String) {
        LoadData.load.fetchMovies(url: url, parameters: setParameters(),complition: { [unowned self]  (movieList: FilmModel) in
            filmData.append(contentsOf: movieList.docs)
            pages = movieList.pages
            filmTableView.reloadData()
        })
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filmData.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "filmCell") as? MovieTableViewCell{
            cell.cellConfigurate(film: filmData[indexPath.row])
            return cell
        }
        return UITableViewCell()

    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndex = filmData.count - 1
        if indexPath.row == lastIndex{
            setPagination()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destenationVC = segue.destination as? ViewController {
            if let cell = sender as? MovieTableViewCell, let index = filmTableView.indexPath(for: cell)?.row{
                destenationVC.detailMovie = filmData[index]
            }
        }
    }

}
