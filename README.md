# 📱 ToDoApp - iOS UIKit To-Do Application

A modern and user-friendly iOS task management (To-Do) application developed entirely with **Swift & UIKit**.

The application provides features such as creating, editing, completing, deleting, searching, and filtering tasks, along with support for an **optional due date**.

No third-party libraries are used in this project. The application is built entirely with Apple's native UIKit components and local data persistence solutions.

---

## ✨ Features

### 📋 Task Listing & Management

Tasks can be displayed with:

- Task title
- Optional note
- Optional due date
- Completed / pending status

### ➕ Add New Task

Users can create a new task through a modal form.

- Task title is required.
- An optional note can be added.
- An optional due date can be added.
- The task is saved and added to the main list.

### ✏️ Edit Task

Existing tasks can be selected and edited.

Users can:

- Change the task title.
- Edit the note.
- Change the due date.
- Remove the due date.

### 📅 Optional Due Date

Adding a due date is completely optional.

The due date feature can be enabled or disabled using a `UISwitch`.

When enabled:

- A date can be selected using `UIDatePicker`.
- A specific time can also be selected.
- Date and time are displayed using a localized Turkish format.
- Tasks can also be created without a due date.

Example:

```text
Due Date: 04 Sep 2026, 16:38
```

### ✅ Quick Completion & Strikethrough Text

- The task status can be changed between completed and pending with a single tap on the check button.
- Completed task titles are automatically displayed with a strikethrough effect using `NSAttributedString`.

### 🗑️ Swipe to Delete

- Tasks can be quickly deleted by swiping from right to left.
- A red **Delete** button is displayed using `UIContextualAction`.

### 🔍 Search & Status Filtering

- **UISearchController:** Provides real-time filtering based on task titles or notes.
- **UISegmentedControl:** Groups tasks into **All**, **Pending**, and **Completed** sections.
- Search and status filtering can be used together.

### 💾 Persistent Data Storage

- All tasks are converted to JSON using `Codable` and stored in `UserDefaults`.
- Tasks are preserved even after the application is completely closed.
- Each task has a unique identifier generated using `UUID`.

Data flow:

```text
ToDoItem
    ↓
Codable
    ↓
JSON
    ↓
UserDefaults
```

### 🌗 Dark Mode Support

- The application fully supports Light Mode and Dark Mode.
- Apple's dynamic system colors such as `systemBackground`, `label`, and `secondaryLabel` are used.
- The interface automatically adapts to the system appearance.

---

## 🛠️ Technologies & Components

| Category | Technology / Class | Description |
| :--- | :--- | :--- |
| **Language** | Swift | iOS application development |
| **UI Framework** | UIKit | Apple's native UI framework |
| **Layout** | Programmatic Auto Layout | Code-based UI using `NSLayoutConstraint` |
| **List** | `UITableView` | Task listing |
| **Custom Cell** | `UITableViewCell` | Custom task cell design |
| **Navigation** | `UINavigationController` | Navigation between screens |
| **Search** | `UISearchController` | Real-time task search |
| **Filtering** | `UISegmentedControl` | Filtering tasks by status |
| **Date Selection** | `UIDatePicker` | Due date and time selection |
| **Toggle** | `UISwitch` | Enable / disable due date |
| **Date Formatting** | `DateFormatter` | Localized date and time formatting |
| **Data Model** | `Codable` | JSON serialization and deserialization |
| **Local Storage** | `UserDefaults` | Persistent task storage |
| **ID** | `UUID` | Unique task identifier |
| **Text Formatting** | `NSAttributedString` | Strikethrough effect |
| **Swipe Action** | `UIContextualAction` | Swipe-to-delete functionality |

---

## 📂 Project Structure

```text
ToDoApp/
├── AppDelegate.swift
├── SceneDelegate.swift
│
├── Models/
│   └── ToDoItem.swift
│
├── Views/
│   └── ToDoCell.swift
│
└── ViewControllers/
    ├── TodoListViewController.swift
    └── AddEditTodoViewController.swift
```

### File Responsibilities

- **`AppDelegate.swift`**  
  Manages the application's main lifecycle events.

- **`SceneDelegate.swift`**  
  Manages the Scene lifecycle for iOS 13+ and the application's main `UIWindow`.

- **`ToDoItem.swift`**  
  Defines the task data model, including title, note, completion status, unique ID, and optional due date.

- **`ToDoCell.swift`**  
  Custom `UITableViewCell` used to display tasks in the main list.

- **`TodoListViewController.swift`**  
  Manages task listing, searching, filtering, completing, deleting, and persistent data operations.

- **`AddEditTodoViewController.swift`**  
  Manages creating and editing tasks, including optional due date selection.

---

## 📐 UI Design

The entire user interface is built using a **Programmatic Auto Layout** approach.

The project does not use:

- Storyboards
- XIB files
- Interface Builder

All UIKit components are created programmatically using Swift.

Auto Layout is implemented using:

```swift
NSLayoutConstraint
```

and:

```swift
translatesAutoresizingMaskIntoConstraints = false
```

---

## 📸 Screenshots

### ☀️ Task List - Light Mode

<p align="center">
  <img width="350" alt="Task List - Light Mode" src="https://github.com/user-attachments/assets/889821ff-d8be-4766-9cfa-c2060c6d3787" />
</p>

### ➕ Add / Edit Task

<p align="center">
  <img width="350" alt="Add / Edit Task" src="https://github.com/user-attachments/assets/976534f1-7312-4cee-880a-db6bb108b23b" />
</p>

### 🌙 Task List - Dark Mode

<p align="center">
  <img width="350" alt="Task List - Dark Mode" src="https://github.com/user-attachments/assets/69a01d32-a103-409b-851e-8b6212d8025e" />
</p>


## ▶️ Installation & Running

### 1. Clone the Repository

```bash
https://github.com/yuksel17/To-Do-App
```

### 2. Open the Project

Open:

```text
ToDoApp.xcodeproj
```

with **Xcode**.

### 3. Select a Simulator

Select an iPhone Simulator such as:

```text
iPhone 16 Pro
iPhone 17 Pro
```

### 4. Run the Application

Press:

**Command + R**

or click the **▶ Run** button in Xcode.

---

## 🌗 Dark Mode Testing

While the Simulator is running, use:

```text
Command + Shift + A
```

to switch between Light Mode and Dark Mode.

---

## 💾 Data Persistence Architecture

The application uses `UserDefaults` and `Codable` for persistent local data storage.

### Saving Data

```text
User
    ↓
New Task
    ↓
ToDoItem
    ↓
Codable
    ↓
JSON Data
    ↓
UserDefaults
```

### Loading Data

```text
UserDefaults
    ↓
JSON Data
    ↓
Codable
    ↓
ToDoItem
    ↓
UITableView
```

This ensures that tasks remain available even after the application is completely closed and reopened.

---

## 🎯 Project Purpose

This project was developed to gain practical experience with **UIKit and iOS application development** while following a programmatic UI development approach.

The project focuses on:

- Swift
- UIKit
- View Controller architecture
- AppDelegate & SceneDelegate
- Programmatic UI
- Auto Layout
- `UITableView`
- Custom `UITableViewCell`
- `UINavigationController`
- `UISearchController`
- `UISegmentedControl`
- `UISwitch`
- `UIDatePicker`
- `DateFormatter`
- `Codable`
- `UserDefaults`
- JSON Serialization
- `UUID`
- `NSAttributedString`
- Swipe to Delete
- Light / Dark Mode
- Memory Management
- `weak self`

---


# 📱 ToDoApp - iOS UIKit To-Do Uygulaması

Tamamen **Swift & UIKit** kullanılarak geliştirilmiş, modern ve kullanıcı dostu bir iOS görev yönetimi (To-Do) uygulamasıdır.

Uygulama; görev oluşturma, düzenleme, tamamlama, silme, arama ve filtreleme özelliklerinin yanı sıra **isteğe bağlı teslim tarihi** desteği sunmaktadır.

Projede herhangi bir 3. parti kütüphane kullanılmamış, Apple'ın native UIKit bileşenleri ve yerel veri saklama çözümleri kullanılmıştır.

---

## ✨ Özellikler

### 📋 Görev Listeleme & Yönetimi

Görevler aşağıdaki bilgilerle birlikte listelenebilir:

- Görev başlığı
- İsteğe bağlı not
- İsteğe bağlı teslim tarihi
- Tamamlandı / bekliyor durumu

### ➕ Yeni Görev Ekleme

Kullanıcı modal form ekranı üzerinden yeni görev oluşturabilir.

- Görev başlığı zorunludur.
- İsteğe bağlı not eklenebilir.
- İsteğe bağlı teslim tarihi eklenebilir.
- Görev kaydedilerek ana listeye eklenir.

### ✏️ Görev Düzenleme

Mevcut görevler listeden seçilerek düzenlenebilir.

Kullanıcı:

- Görev başlığını değiştirebilir.
- Notları düzenleyebilir.
- Teslim tarihini değiştirebilir.
- Teslim tarihini kaldırabilir.

### 📅 İsteğe Bağlı Teslim Tarihi

Görevlere teslim tarihi eklemek zorunlu değildir.

`UISwitch` kullanılarak teslim tarihi özelliği aktif veya pasif hale getirilebilir.

Teslim tarihi aktif edildiğinde:

- `UIDatePicker` ile tarih seçilebilir.
- Saat seçilebilir.
- Tarih ve saat Türkçe yerelleştirilmiş formatta gösterilir.
- Görev teslim tarihi olmadan da oluşturulabilir.

Örneğin:

```text
Son Teslim: 04 Eyl 2026, 16:38
```

### ✅ Hızlı Tamamlama & Çizgili Metin

- Listedeki onay butonuna tek dokunuşla görevin durumu tamamlandı/bekliyor olarak değiştirilebilir.
- Tamamlanan görevlerin başlıkları `NSAttributedString` kullanılarak otomatik olarak üstü çizili hale getirilir.

### 🗑️ Kaydırarak Silme (Swipe to Delete)

- Görevler sağdan sola kaydırılarak hızlıca silinebilir.
- Kırmızı **Sil** butonu `UIContextualAction` kullanılarak oluşturulmuştur.

### 🔍 Arama ve Durum Filtreleme

- **UISearchController:** Başlık veya not içerisinde gerçek zamanlı arama yapar.
- **UISegmentedControl:** Görevleri **Tümü**, **Bekleyenler** ve **Tamamlananlar** olarak filtreler.
- Arama ve durum filtreleme birlikte kullanılabilir.

### 💾 Kalıcı Veri Saklama

- Tüm görevler `Codable` kullanılarak JSON formatına dönüştürülür ve `UserDefaults` içerisinde saklanır.
- Uygulama tamamen kapatılsa bile görevler korunur.
- Her görev `UUID` kullanılarak benzersiz bir kimliğe sahiptir.

Veri akışı:

```text
ToDoItem
    ↓
Codable
    ↓
JSON
    ↓
UserDefaults
```

### 🌗 Karanlık Mod (Dark Mode) Desteği

- Uygulama hem Light Mode hem de Dark Mode'u destekler.
- `systemBackground`, `label` ve `secondaryLabel` gibi Apple dinamik sistem renkleri kullanılmıştır.
- Arayüz sistem temasına otomatik olarak uyum sağlar.

---

## 🛠️ Kullanılan Teknolojiler ve Bileşenler

| Kategori | Teknoloji / Sınıf | Açıklama |
| :--- | :--- | :--- |
| **Dil** | Swift | iOS uygulama geliştirme |
| **Arayüz** | UIKit | Apple'ın native UI framework'ü |
| **Layout** | Programmatic Auto Layout | `NSLayoutConstraint` ile kod tabanlı arayüz |
| **Listeleme** | `UITableView` | Görevlerin listelenmesi |
| **Özel Hücre** | `UITableViewCell` | Özel görev hücresi |
| **Navigation** | `UINavigationController` | Ekranlar arası geçiş |
| **Arama** | `UISearchController` | Gerçek zamanlı görev arama |
| **Filtreleme** | `UISegmentedControl` | Görev durumuna göre filtreleme |
| **Tarih Seçimi** | `UIDatePicker` | Teslim tarihi ve saat seçimi |
| **Toggle** | `UISwitch` | Teslim tarihini açıp kapatma |
| **Tarih Formatı** | `DateFormatter` | Yerelleştirilmiş tarih ve saat gösterimi |
| **Veri Modeli** | `Codable` | JSON serileştirme |
| **Local Storage** | `UserDefaults` | Kalıcı görev saklama |
| **ID** | `UUID` | Benzersiz görev kimliği |
| **Metin Biçimlendirme** | `NSAttributedString` | Üstü çizili metin |
| **Swipe Action** | `UIContextualAction` | Kaydırarak silme |

---

## 📂 Proje Yapısı

```text
ToDoApp/
├── AppDelegate.swift
├── SceneDelegate.swift
│
├── Models/
│   └── ToDoItem.swift
│
├── Views/
│   └── ToDoCell.swift
│
└── ViewControllers/
    ├── TodoListViewController.swift
    └── AddEditTodoViewController.swift
```

### Dosyaların Sorumlulukları

- **`AppDelegate.swift`**  
  Uygulamanın temel yaşam döngüsü işlemlerini yönetir.

- **`SceneDelegate.swift`**  
  iOS 13+ Scene yaşam döngüsünü ve uygulamanın ana `UIWindow` yapısını yönetir.

- **`ToDoItem.swift`**  
  Görev veri modelini tanımlar. Başlık, not, tamamlanma durumu, benzersiz ID ve isteğe bağlı teslim tarihi bilgilerini içerir.

- **`ToDoCell.swift`**  
  Görevlerin `UITableView` içerisinde görüntülenmesini sağlayan özel hücre yapısıdır.

- **`TodoListViewController.swift`**  
  Görev listeleme, arama, filtreleme, tamamlama, silme ve kalıcı veri işlemlerini yönetir.

- **`AddEditTodoViewController.swift`**  
  Yeni görev ekleme ve mevcut görevleri düzenleme işlemlerini yönetir.

---

## 📐 Arayüz Tasarımı

Uygulamanın arayüzü tamamen **Programmatic Auto Layout** yaklaşımıyla oluşturulmuştur.

Projede:

- Storyboard kullanılmamıştır.
- XIB kullanılmamıştır.
- Interface Builder kullanılmamıştır.
- Tüm UIKit bileşenleri Swift kodu ile oluşturulmuştur.
- `NSLayoutConstraint` kullanılmıştır.
- `translatesAutoresizingMaskIntoConstraints = false` yaklaşımı kullanılmıştır.

---

## 📸 Ekran Görüntüleri

### ☀️ Görev Listesi - Açık Tema

<p align="center">
  <img width="350" alt="Görev Listesi - Açık Tema" src="https://github.com/user-attachments/assets/889821ff-d8be-4766-9cfa-c2060c6d3787" />
</p>

### ➕ Görev Ekleme / Düzenleme

<p align="center">
  <img width="350" alt="Görev Ekleme ve Düzenleme" src="https://github.com/user-attachments/assets/976534f1-7312-4cee-880a-db6bb108b23b" />
</p>

### 🌙 Görev Listesi - Karanlık Tema

<p align="center">
  <img width="350" alt="Görev Listesi - Karanlık Tema" src="https://github.com/user-attachments/assets/69a01d32-a103-409b-851e-8b6212d8025e" />
</p>
Yeni görev oluşturma veya mevcut görevi düzenleme ekranında görev başlığı ve isteğe bağlı not girilebilir.

`Teslim Tarihi Ekle` anahtarı aktif edildiğinde tarih ve saat seçilebilir.


Uygulama Apple'ın Dynamic System Colors yapısını kullanarak Dark Mode ile uyumlu şekilde çalışmaktadır.

---

## ▶️ Kurulum ve Çalıştırma

### 1. Repository'yi klonlayın

```bash
git clone https://github.com/yuksel17/To-Do-App.git
```

### 2. Proje klasörüne girin

```bash
cd ToDoApp
```

### 3. Xcode ile açın

```text
ToDoApp.xcodeproj
```

dosyasını **Xcode** ile açın.

### 4. Simulator seçin

Xcode üzerinden bir iOS Simulator veya bağlı iPhone cihazı seçin.

### 5. Uygulamayı çalıştırın

**Command + R** tuşlarına basın veya Xcode'daki **▶ Run** butonuna tıklayın.

### 5. Uygulamayı çalıştırın

**Command + R** tuşlarına basın veya Xcode'daki **▶ Run** butonuna tıklayın.

---

## 🌗 Dark Mode Testi

Simulator çalışırken:

```text
Command + Shift + A
```

kısayolunu kullanarak Light Mode ve Dark Mode arasında geçiş yapabilirsiniz.

---

## 💾 Veri Saklama Mimarisi

Görevlerin kalıcı olarak saklanması için `UserDefaults` ve `Codable` kullanılmıştır.

### Veri Kaydetme

```text
Kullanıcı
    ↓
Yeni Görev
    ↓
ToDoItem
    ↓
Codable
    ↓
JSON Data
    ↓
UserDefaults
```

### Veri Yükleme

```text
UserDefaults
    ↓
JSON Data
    ↓
Codable
    ↓
ToDoItem
    ↓
UITableView
```

Bu yapı sayesinde uygulama tamamen kapatılsa bile oluşturulan görevler korunur.

---

## 🎯 Projenin Amacı

Bu proje, **UIKit ve iOS uygulama geliştirme temellerini** uygulamalı olarak öğrenmek ve programatik arayüz geliştirme yaklaşımını kullanmak amacıyla hazırlanmıştır.

Proje geliştirilirken özellikle aşağıdaki konular üzerinde çalışılmıştır:

- Swift
- UIKit
- View Controller yapısı
- AppDelegate & SceneDelegate
- Programmatic UI
- Auto Layout
- `NSLayoutConstraint`
- `UITableView`
- Custom `UITableViewCell`
- `UINavigationController`
- `UISearchController`
- `UISegmentedControl`
- `UISwitch`
- `UIDatePicker`
- `DateFormatter`
- `Codable`
- `UserDefaults`
- JSON Serialization
- `UUID`
- `NSAttributedString`
- Swipe to Delete
- Light / Dark Mode
- Memory Management
- `weak self`

---

## 👩‍💻 Geliştirici

**ToDoApp**

Swift ve UIKit kullanılarak geliştirilmiştir.

**Technologies:** Swift · UIKit · Auto Layout · UserDefaults · Codable
