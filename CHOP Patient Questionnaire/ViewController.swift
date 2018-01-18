//
//  ViewController.swift
//  CHOP Patient Questionnaire
//
//  Created by   on 11/29/17.
//  Copyright © 2017 Alan Tsai. All rights reserved.
//

import UIKit

struct Question{
    var questionString: String?
    var answers:[String]?
    var selectedAnswerIndex: Int?
}

var questionsList: [Question] = [Question(questionString: "Do you have Cardiology or Heart Problem?", answers: ["Yes", "No"], selectedAnswerIndex: nil), Question(questionString: "Copy of cardiology letter needed", answers: ["Normal", "Heart condition resolved"], selectedAnswerIndex: nil), Question(questionString: "Heart condition resolved?", answers: ["Yes", "No"], selectedAnswerIndex: nil)]


class QuestionController: UITableViewController{
    
    let cellID = "cellID"
    let headerID = "headerID"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "CHOP Patient Questionnaire"
        
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: nil, action: nil)
        
        tableView.registerClass(AnswerCell.self, forCellReuseIdentifier: cellID)
        tableView.registerClass(QuestionHeader.self, forHeaderFooterViewReuseIdentifier: headerID)
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.sectionHeaderHeight = 50
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let index = navigationController?.viewControllers.indexOf(self){
            let question = questionsList[index]
            if let count = question.answers?.count{
                return count
            }
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! AnswerCell
        
        if let index = navigationController?.viewControllers.indexOf(self){
            let question = questionsList[index]
            cell.nameLabel.text = question.answers?[indexPath.row]
        }
        
        return cell
    }

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(headerID)
            as! QuestionHeader
        
        if let index = navigationController?.viewControllers.indexOf(self){
            let question = questionsList[index]
            header.nameLabel.text = question.questionString
        }
        return header
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let index = navigationController?.viewControllers.indexOf(self){
            questionsList[index].selectedAnswerIndex = indexPath.item
            
            if index < questionsList.count - 1 {
                let questionController = QuestionController()
                navigationController?.pushViewController(questionController, animated: true)
            } else {
                let controller = ResultsController()
                navigationController?.pushViewController(controller, animated: true)
            }
        }
    }

}

class ResultsController: UIViewController{
    
    
    let resultsLabel: UILabel = {
        let label = UILabel()
        label.text = "Congrats, go to the doctor"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .Center
        label.font = UIFont.boldSystemFontOfSize(14)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "done")
        
        navigationItem.title = "Results"
        
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(resultsLabel)
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": resultsLabel]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": resultsLabel]))
        
        let names = ["Surgery", "In EPIC, Ok for ASC"]
        
        var score = 0
        for question in questionsList {
            score += question.selectedAnswerIndex!
        }
        
        let result = names[score % names.count]
        resultsLabel.text = "\(result)."
        //print(question.selectedAnswerIndex)
        }
    
    func done(){
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
}

class QuestionHeader: UITableViewHeaderFooterView{
    override init(reuseIdentifier: String?){
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Question"
        label.font = UIFont.boldSystemFontOfSize(14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews(){
        addSubview(nameLabel)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AnswerCell: UITableViewCell{
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Answer"
        label.font = UIFont.systemFontOfSize(14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews(){
        addSubview(nameLabel)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
    }
    
    

}