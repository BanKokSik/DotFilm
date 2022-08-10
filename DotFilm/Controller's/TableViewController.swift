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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        filmTableView.dataSource = self
        filmTableView.delegate = self
        setData()
    }

    
    private func setData() {
        LoadData.load.fetchMovies(complition: { (movieList: [Doc]) in
            self.filmData = movieList
            self.filmTableView.reloadData()
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destenationVC = segue.destination as? ViewController {
            if let cell = sender as? MovieTableViewCell, let index = filmTableView.indexPath(for: cell)?.row{
                destenationVC.detailMovie = filmData[index]
            }
        }
    }

}
