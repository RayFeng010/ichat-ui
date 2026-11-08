# iChat UI

[中文](#中文版) | [English](#english-version)

---

## 中文版

### 📖 项目简介

iChat UI 是一个基于 **Qt 6 / QML** 开发的仿 QQ 聊天软件纯 UI 项目。项目专注于高还原度的聊天界面交互与视觉体验，采用 QML 构建现代化、流畅的聊天窗口、消息气泡、联系人列表等核心 UI 组件，适合作为 QML 界面开发学习参考或即时通讯应用的前端原型。

> **注意**：本项目为纯 UI 实现，不包含网络通信、消息存储等后端逻辑，所有数据均为静态模拟数据。

### ✨ 功能特性

- **仿 QQ 风格界面**——高度还原 QQ 聊天窗口的布局与视觉风格
- **消息气泡**——支持多种样式消息气泡，通过 `Bubble` 组件及配套 JS 文件动态生成气泡路径
- **联系人/会话列表**——展示联系人及最近会话，支持列表交互
- **表情与富文本**——内置 Emoji 资源，支持消息中的表情显示
- **自定义控件库**——`QianControls` 与 `RelaxControls` 两个自定义控件模块，提供可复用的 UI 组件
- **无边框窗口**——支持自定义标题栏与窗口拖拽，打造沉浸式桌面体验
- **GIF 动图支持**——集成 `giftext_handler`，可在消息文本中嵌入动图

### 🗂️ 项目结构

```text
ichat-ui/
├── QianControls/        # 自定义控件模块（Qian 系列）
├── RelaxControls/       # 自定义控件模块（Relax 系列）
├── Qml/                 # 主要 QML 界面文件
│   └── Bubble/          # 消息气泡组件及 JS 路径生成脚本
├── Resources/           # 图片、Emoji、GIF 等静态资源
├── doc/font-awesome/    # Font Awesome 图标字体
├── CMakeLists.txt       # CMake 构建配置
└── main.cpp             # 程序入口
```

### 🛠️ 技术栈

| 类别    | 技术                                          |
| ----- | ------------------------------------------- |
| UI 框架 | Qt Quick / QML                              |
| 语言    | C++20、QML、JavaScript                        |
| 构建工具  | CMake ≥ 3.28                                |
| Qt 版本 | Qt 6.8+（依赖 Quick、QuickControls2、Multimedia） |
| 图标    | Font Awesome                                |
| 平台    | Windows / Linux / macOS（Qt 跨平台）             |

### 🚀 构建与运行

#### 环境要求

- Qt 6.8 或更高版本（含 Quick、QuickControls2、Multimedia 模块）
- CMake 3.28+
- 支持 C++20 的编译器（MSVC 2022 / GCC 13+ / Clang 16+）
- Qt Creator（推荐）或命令行构建

#### 命令行构建

```bash
# 克隆仓库
git clone https://github.com/RayFeng010/ichat-ui.git
cd ichat-ui

# 创建构建目录
mkdir build && cd build

# 构建 Qt Creator
```

构建完成后运行 `iChat-ui` 可执行文件即可启动界面。

#### Qt Creator

1. 用 Qt Creator 打开项目根目录的 `CMakeLists.txt`
2. 选择 Qt 6.8+ 的 Kit
3. 点击 **构建** → **运行**

### 📌 说明

- 本项目为 **纯 UI 项目**，所有聊天数据、联系人、消息均为前端模拟，未连接任何即时通讯服务。
- 消息气泡的动态路径由 `Qml/Bubble/` 下的 JS 脚本生成，可作为 QML 中动态图形绘制的参考。
- 自定义控件位于 `QianControls` 和 `RelaxControls`，可独立复用到其他 QML 项目中。

### 📄 许可

本项目未显式声明开源许可证，使用前请参考仓库实际许可情况。Font Awesome 图标字体遵循其原始许可条款。QianControls移植于https://blog.csdn.net/qq_37997682/category_11280267.html

### 运行效果
<img width="980" height="660" alt="contact" src="https://github.com/user-attachments/assets/a16f392d-8ce1-45e4-86a7-837da98485b6" />

<img width="986" height="666" alt="image" src="https://github.com/user-attachments/assets/883aaa2e-4637-4360-b357-e37f8a0ed859" />



---

## English Version

### 📖 Overview

**iChat UI** is a pure UI project built with **Qt 6 / QML**, replicating the look and feel of the QQ chat application. It focuses on delivering a high-fidelity chat interface—including chat windows, message bubbles, contact lists, and other core UI components—with smooth, modern QML interactions. The project serves as a learning reference for QML UI development and a front-end prototype for instant messaging applications.

> **Note**: This is a **pure UI project**. It does not include networking, message persistence, or any backend logic. All data is statically mocked on the front end.

### ✨ Features

- **QQ-inspired interface** — Faithfully reproduces the layout and visual style of the QQ chat client
- **Message bubbles** — Multiple bubble styles dynamically generated via the `Bubble` component and associated JavaScript files
- **Contact / conversation list** — Displays contacts and recent conversations with interactive list behavior
- **Emoji & rich text** — Built-in Emoji resources; emojis can be embedded in messages
- **Custom control libraries** — `QianControls` and `RelaxControls` provide reusable UI components
- **Frameless window** — Custom title bar and window dragging for an immersive desktop experience
- **GIF support** — Integrated `giftext_handler` enables animated GIFs within message text

### 🗂️ Project Structure

```text
ichat-ui/
├── QianControls/        # Custom control module (Qian series)
├── RelaxControls/       # Custom control module (Relax series)
├── Qml/                 # Main QML interface files
│   └── Bubble/          # Message bubble components & JS path generators
├── Resources/           # Images, Emoji, GIFs, and other static assets
├── doc/font-awesome/    # Font Awesome icon font
├── CMakeLists.txt       # CMake build configuration
└── main.cpp             # Application entry point
```

### 🛠️ Tech Stack

| Category     | Technology                                  |
| ------------ | ------------------------------------------- |
| UI Framework | Qt Quick / QML                              |
| Languages    | C++20, QML, JavaScript                      |
| Build System | CMake ≥ 3.28                                |
| Qt Version   | Qt 6.8+ (Quick, QuickControls2, Multimedia) |
| Icons        | Font Awesome                                |
| Platform     | Windows / Linux / macOS (Qt cross-platform) |

### 🚀 Build & Run

#### Prerequisites

- Qt 6.8 or later (with Quick, QuickControls2, and Multimedia modules)
- CMake 3.28+
- A C++20-compatible compiler (MSVC 2022 / GCC 13+ / Clang 16+)
- Qt Creator (recommended) or command-line toolchain

#### Command-Line Build

```bash
# Clone the repository
git clone https://github.com/RayFeng010/ichat-ui.git
cd ichat-ui

# Create a build directory
mkdir build && cd build

# Build with Qt Creator
```

After a successful build, run the `iChat-ui` executable to launch the interface.

#### Qt Creator

1. Open `CMakeLists.txt` from the project root in Qt Creator
2. Select a Qt 6.8+ Kit
3. Click **Build** → **Run**

### 📌 Notes

- This is a **UI-only project**; all chat data, contacts, and messages are front-end mocks with no connection to any instant messaging service.
- Dynamic bubble paths are generated by the JavaScript files under `Qml/Bubble/`, which can serve as a reference for dynamic graphics in QML.
- Custom controls in `QianControls` and `RelaxControls` are designed to be reusable across other QML projects.

### 📄 License

No explicit open-source license is declared in this repository. Please refer to the actual licensing status of the repository before use. The Font Awesome icon font is subject to its original license terms.QianControls copy from https://blog.csdn.net/qq_37997682/category_11280267.html
