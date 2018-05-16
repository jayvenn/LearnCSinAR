//
//  CourseViewController.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 4/26/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit

class CourseViewController: UIViewController {
    
    let course: Course
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    init(course: Course) {
        self.course = course
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: CourseViewController - Life cycles
extension CourseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCell()
        setUpLayout()
        setUpUI()
    }

}

// MARK: CourseViewController - UI, Layout, Overhead
extension CourseViewController {
    
    private func registerTableViewCell() {
        tableView.register(LessonTableViewCell.self, forCellReuseIdentifier: TableViewCellReuseIdentifier.LessonTableViewCell.rawValue)
    }
    
    private func setUpLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
        title = course.name
    }
    
}

// MARK: CourseViewController - UITableViewDelegate
extension CourseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lesson = course.lessons[indexPath.row]
        let viewController = ARLessonViewController(lesson: lesson)
        present(viewController, animated: true)
    }
}

// MARK: CourseViewController - UITableViewDataSource
extension CourseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return course.lessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellReuseIdentifier.LessonTableViewCell.rawValue, for: indexPath) as? LessonTableViewCell else { return UITableViewCell() }
        let lesson = course.lessons[indexPath.row]
        cell.configureCell(lesson: lesson)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}
