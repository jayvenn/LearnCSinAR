//
//  CoursesViewController.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 4/26/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit

// MARK: CoursesViewController
class CoursesViewController: BaseMenuViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.accessibilityValue = "Courses"
        tableView.accessibilityHint = "Select course"
        tableView.rowHeight = UITableView.automaticDimension
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
//        return [dataStructuresCourse, algorithmsCourse, sortingCourse]
        return [dataStructuresCourse]
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
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(CoursesViewController.rightBarItemDidTouchUpInside))
        return barButtonItem
    }()
    
    @objc func rightBarItemDidTouchUpInside(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func configureView() {
        super.configureView()
        tableView.reloadData()
    }
}

// MARK: CoursesViewController - Life cycles
extension CoursesViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCells()
        setUpLayout()
        setUpUI()
        loadTableView()
        title = NSLocalizedString("Select a Course", comment: "Select a Course")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
}

// MARK: CoursesViewController - UI, Layout, Overhead
extension CoursesViewController {
    
    private func registerTableViewCells() {
        tableView.register(MenuTableViewCell.self,
                           forCellReuseIdentifier: TableViewCellReuseIdentifier.MenuTableViewCell.rawValue)
    }
    
    private func setUpLayout() {
        view.addSubviews(views: [
            tableView
            ])
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
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

// MARK: CoursesViewController - UITableViewDelegate
extension CoursesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = courses[indexPath.row]
        let courseViewController = LessonsViewController(course: course)
//        let title = NSLocalizedString("Back", comment: "Back")
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
        show(courseViewController, sender: nil)
    }
}

// MARK: CoursesViewController - UITableViewDataSource
extension CoursesViewController: UITableViewDataSource {
    
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
        return UITableView.automaticDimension
    }
}

