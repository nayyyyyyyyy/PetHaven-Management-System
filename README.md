# Pet Haven Management System

A robust, full-stack Java Web Application designed to streamline modern animal shelter operations. This system replaces legacy manual tracking with a centralized, secure interface for managing pet records, intake details, and adoption statuses while maintaining top-tier algorithmic efficiency and data validation.

---

## 🚀 Key Features

* **Algorithmic Search & Sort:** Utilizes custom-coded Merge Sort and Binary Search engines to ensure predictable, lightning-fast data retrieval and indexing without relying on built-in utilities.
* **Secure Data Persistence:** Built with an encapsulated Singleton database configuration layer connecting to a MySQL backend, leveraging parameterized queries via `PreparedStatement` to block SQL Injection.
* **Defensive Architecture:** Implements server-side validation filters, custom routing via `RequestDispatcher`, and global error boundaries (`404`/`500` status pages) inside the `web.xml` deployment descriptor.
* **Modern UI Dashboard:** Provides a clean, intuitive admin interface optimizing everyday workflows for shelter workers and administrators.

---

## 📊 Performance Metrics

The custom-coded algorithms scale efficiently across dense dataset boundaries:

| Database Scale (N) | Custom Binary Search (`O(log N)`) | Custom Merge Sort (`O(N log N)`) |
| :--- | :--- | :--- |
| **50 Records** | 0.01 ms | 0.45 ms |
| **500 Records** | 0.03 ms | 4.82 ms |
| **5,000 Records** | 0.05 ms | 58.10 ms |

---

## 🛠️ Technology Stack

* **Backend:** Java (Java Servlets, JSP)
* **Dependency Management:** Maven
* **Database:** MySQL (via XAMPP local node configuration)
* **Server Container:** Apache Tomcat
* **Design Patterns:** MVC (Model-View-Controller), Singleton Pattern, Post/Redirect/Get (PRG) Pattern

---

## ⚙️ Local Deployment Guide

To get the application up and running on your local machine:

### 1. Database Setup
1. Open the **XAMPP Control Panel** and start **Apache** and **MySQL**.
2. Navigate to `http://localhost/phpmyadmin` in your web browser.
3. Create a new database named `pet_haven`.
4. Click on the **Import** tab, select the provided `.sql` database backup file from this repository, and click **Go**.

### 2. IDE Configuration (Eclipse)
1. Open Eclipse IDE and choose **File** ➔ **Import** ➔ **Existing Maven Projects**.
2. Select your cloned repository directory and click **Finish**.
3. Right-click the project folder ➔ **Properties** ➔ **Targeted Runtimes** and ensure your **Apache Tomcat** server is selected.
4. Verify your local credentials match the database setup inside `DBConfig.java`.

### 3. Execution
1. Right-click the project name in Eclipse.
2. Select **Run As** ➔ **Run on Server**.
3. Access the dashboard view directly through your web browser.


