<<<<<<< HEAD
=======
# 📸 Instagram "Pixel-Perfect" Feed Challenge

A highly polished, visually identical replication of the Instagram Home Feed built with Flutter, focusing on performance, clean architecture, and complex touch interactions.

## 🔗 Submission Details
- **GitHub Repository**: https://github.com/Priyam475/InstaH
- **Demo Video**: [INSERT_YOUR_DEMO_LINK_HERE] (Showing Shimmer, Infinite Scroll, Pinch-to-Zoom, and Toggles)

---

## 🚀 Key Features

- **The "Mirror" Test**: Identical replication of the Home Feed, including the Top Bar, Stories Tray, and Post Feed.
- **Advanced Media Handling**:
  - **Carousel**: Smooth horizontal scrolling for multi-image posts with synchronized dot indicators.
  - **Pinch-to-Zoom**: Custom implementation using Flutter's Overlay system to scale images over the entire UI with a smooth "snap-back" animation.
- **Stateful Interactions**: Instant local state updates for "Like" and "Save" actions.
- **Infinite Scroll**: Automated pagination (lazy loading) that fetches 10 posts at a time when near the bottom of the feed.
- **Custom Feedback**: Custom persistent SnackBar for unimplemented features (Share, Comments).

---

## 🛠 Tech Stack & Architecture

### **State Management: Riverpod**
I chose **Riverpod** for this project because:
- **Provider-like Simplicity, BLoC-like Power**: It offers a compile-safe way to manage state without the boilerplate of BLoC.
- **Asynchronous Data Handling**: Its `AsyncValue` type makes handling loading, error, and data states (like our simulated API feed) extremely elegant.
- **Testability**: Riverpod's dependency injection makes it easy to mock the `PostRepository` for testing.

### **Project Structure**
The project follows a clean separation of concerns:
- `lib/models/`: Pure data classes (User, Post, Story).
- `lib/services/`: Mock Data Layer (`PostRepository`) with simulated 1.5s latency.
- `lib/providers/`: Business logic and state handling using `StateNotifier`.
- `lib/widgets/`: Modular, reusable UI components.

---

## 📦 Technical Highlights
- **Asset Strategy**: No bundled images; all high-quality assets are loaded and cached via `cached_network_image`.
- **Loading UX**: Custom `Shimmer` effects are used instead of standard spinners for a premium feel.
- **Scroll Physics**: "Jank-free" scrolling performance even with complex overlay interactions.

---

## ⚙️ How to Run
1. **Prerequisites**: Ensure you have Flutter 3.x installed.
2. **Clone & Enter**:
   ```bash
   git clone https://github.com/Priyam475/instahome.git
   cd insta
   ```
3. **Install Dependencies**:
   ```bash
   flutter pub get
   ```
4. **Run the App**:
   ```bash
   flutter run
   ```

---

## 🎥 Checklist for Submission
- [x] Shimmer loading state (1.5s simulated delay).
- [x] Smooth infinite scrolling (Pagination).
- [x] Pinch-to-Zoom overlay (Scales over UI).
- [x] Toggle interactions (Like/Save).
- [x] Synchronized Carousel dot indicators.
>>>>>>> e4e7e63 (first)
