//
//  FavoritTableViewController.swift
//  DotFilm
//
//  Created by Nikita Chekmarev on 12.08.2022.
//

import UIKit
import CoreData

class FavoritTableViewController: UITableViewController {
    @IBOutlet var favoritTableViewController: UITableView!
    
    let favIdentifier = "FavoritTableViewCell"
    var favorit: [FavoriteFilm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritTableViewController.dataSource = self
        favoritTableViewController.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = FavoriteFilm.fetchRequest() as NSFetchRequest<FavoriteFilm>
        
        do{
            favorit = try context.fetch(fetchRequest)
        } catch let error {
            print("Could not fetch because of error: \(error).")
    }
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favorit.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: favIdentifier) as? FavoritTableViewCell{

            cell.favoritCellConfigurate(film: favorit[indexPath.row])
        
        return cell
        }
        return UITableViewCell()
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if favorit.count > indexPath.row{
            let fav = favorit[indexPath.row]
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            context.delete(fav)
            favorit.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            appDelegate.saveContext()
            print("Удален")
        }
        
        
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ViewController{
            if let cell = sender as? FavoritTableViewCell, let index = favoritTableViewController.indexPath(for: cell)?.row{
                let docApiModel = Doc.docFrom(dataBaseModel: favorit[index])
                destinationVC.detailMovie = docApiModel
            }
        }
    }

}
