# ⏱️ Flutter: Stopwatch & Time-Tracked Memo App
> **Week 1 Graduation Project** of the "2026 Flutter Career Jumpstart" Curriculum.

This project demonstrates a deep understanding of the **Flutter Widget Lifecycle**, **Resource Management**, and **Asynchronous Data Flow**. It bridges the gap between traditional SI development (VB.NET) and modern reactive mobile programming.

---

## 🎯 Key Objectives
- **Resource Optimization**: Preventing memory leaks by strictly managing object lifecycles.
- **State Security**: Implementing defensive programming techniques for asynchronous UI updates.
- **Complex Navigation**: Facilitating multi-type data exchange between screens using the Navigator API.

---

## 🛠️ Technical Focus & Implementation

### 1. Advanced Lifecycle Management
Unlike static environments, mobile apps require rigorous resource cleanup. I focused on:
- Initializing `Timer` and `TextEditingController` in `initState()`.
- Explicitly releasing resources in `dispose()` to prevent memory overhead.
- **Learning**: Transitioning from SI logic, I realized the critical importance of "Cleaning up after yourself" in a limited-resource mobile environment.

### 2. Defensive UI Updating (`mounted` check)
To prevent the common "setState() called after dispose()" error, I implemented `if (mounted)` guards before every UI update within asynchronous callbacks.



### 3. Type-Safe Data Passing
When navigating between screens, data is passed back via `Navigator.pop`. I ensured type safety by:
- Using `Map<String, dynamic>` for multi-value data packets.
- Implementing **Type Guards** using the `is` keyword (e.g., `if (result is Map<String, dynamic>)`) to prevent runtime crashes.

---

## 🚀 Key Features
- **Real-time Stopwatch**: Accurately tracks time while the user is composing a memo.
- **Dynamic Memo List**: Stores and displays memo content alongside the exact time taken to write it.
- **Input Validation**: Ensures data integrity before saving and popping results back to the main list.

---

## 💻 Tech Stack
- **Framework**: Flutter (Dart)
- **Architecture**: State-based Component UI
- **Key APIs**: `Timer`, `TextEditingController`, `Navigator`

---

## 👤 Developer's Note
As an engineer with a background in SI, I am focused on mastering the nuances of the Flutter framework. This project represents my commitment to building not just "functional" apps, but **"stable and performant"** mobile products for the Japanese startup market.
