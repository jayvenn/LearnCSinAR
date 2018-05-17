//
//  MenuViewController.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 4/26/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit

// MARK: MenuViewController
class MenuViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        return tableView
    }()
    
    let dataStructuresCourse: Course = {
        let course = Course(courseSubject: .dataStructures)
        return course
    }()
    
    let sortingCourse: Course = {
        let course = Course(courseSubject: .sorting)
        return course
    }()
    
    let algorithmsCourse: Course = {
        let course = Course(courseSubject: .algorithms)
        return course
    }()
    
    private var courses: [Course] {
        return [dataStructuresCourse, algorithmsCourse, sortingCourse]
    }
    
    private var indexPaths: [IndexPath] {
        var indexPaths = [IndexPath]()
        for index in courses.startIndex..<courses.endIndex {
            let indexPath = IndexPath(row: index, section: 0)
            indexPaths.append(indexPath)
        }
        return indexPaths
    }
    
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(MenuViewController.rightBarItemDidTouchUpInside))
        return barButtonItem
    }()
    
    @objc func rightBarItemDidTouchUpInside(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: MenuViewController - Life cycles
extension MenuViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCells()
        setUpLayout()
        setUpUI()
        loadTableView()
        title = "Select a Course"
    }
    
}

// MARK: MenuViewController - UI, Layout, Overhead
extension MenuViewController {
    
    private func registerTableViewCells() {
        tableView.register(MenuTableViewCell.self,
                           forCellReuseIdentifier: TableViewCellReuseIdentifier.MenuTableViewCell.rawValue)
    }
    
    private func setUpLayout() {
        view.addSubviews(views: [
            tableView
            ])
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
    }
    
    private func loadTableView() {
        var indexPaths = [IndexPath]()
        for index in courses.startIndex..<courses.endIndex {
            let indexPath = IndexPath(row: index, section: 0)
            indexPaths.append(indexPath)
        }
        tableView.reloadRows(at: indexPaths, with: .automatic)
    }
}

// MARK: MenuViewController - UITableViewDelegate
extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = courses[indexPath.row]
        let courseViewController = CourseViewController(course: course)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        show(courseViewController, sender: nil)
    }
}

// MARK: MenuViewController - UITableViewDataSource
extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellReuseIdentifier.MenuTableViewCell.rawValue, for: indexPath) as? MenuTableViewCell else { return UITableViewCell() }
        let course = courses[indexPath.row]
        cell.configureCell(course: course)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}
