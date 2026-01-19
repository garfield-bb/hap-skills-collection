# HAP Skills Collection

<div align="center">

![HAP Skills](https://img.shields.io/badge/HAP-Skills-blue)
![Claude Code](https://img.shields.io/badge/Claude-Code-orange)
![License](https://img.shields.io/badge/license-MIT-green)

**AI Skills for Mingdao Cloud HAP Platform Development**

Support for **9 major AI tools** with one-click installation

[中文](./README.md) | [English](./README.en.md)

</div>

---

## 📖 Overview

**HAP Skills Collection** is a comprehensive AI skills package for Mingdao Cloud HAP platform development. It enables AI tools like Claude Code, Cursor, TRAE, Windsurf, and more to **automatically understand and use** HAP APIs, development standards, and best practices.

### ✨ Key Features

- 🎯 **Zero Learning Curve** - AI automatically understands HAP APIs
- 🛠️ **Best Practices Built-in** - Based on real-world experience
- 🔄 **Complete Workflows** - From initialization to deployment
- 📚 **Continuously Updated** - Keeps pace with HAP platform updates
- 🔌 **9 Platform Support** - Works with all major AI development tools

---

## ⚡ Quick Start

### One-Click Installation

**macOS / Linux:**
```bash
git clone https://github.com/garfield-bb/hap-skills-collection.git
cd hap-skills-collection
./install.sh --all --global
```

**Windows:**
```powershell
git clone https://github.com/garfield-bb/hap-skills-collection.git
cd hap-skills-collection
.\install.ps1 -All -Global
```

### Verify Installation

Open your AI tool and test:
```
You: Help me query data using HAP V3 API
AI: [Automatically applies HAP V3 API skill]

You: Help me develop a HAP view plugin
AI: [Automatically applies view plugin development skill]
```

---

## 📱 Supported Platforms

| Platform | Compatibility | Installation | Rating |
|----------|---------------|--------------|--------|
| **Claude Code** | ✓ Native | Script/Manual | ⭐⭐⭐⭐⭐ |
| **TRAE** | ✓ Native | Script/Manual | ⭐⭐⭐⭐⭐ |
| **Cursor** | ✓ Native Compatible | Script/Manual | ⭐⭐⭐⭐⭐ |
| **GitHub Copilot** | ✓ Native Compatible | Script/Manual | ⭐⭐⭐⭐ |
| **Google Antigravity** | ✓ Native Compatible | Script/Manual | ⭐⭐⭐⭐ |
| **OpenCode** | ✓ Native Compatible | Script/Manual | ⭐⭐⭐⭐ |
| **Windsurf** | ⚡ Symlink | Auto Script | ⭐⭐⭐⭐ |
| **Gemini CLI** | ⚡ Symlink | Auto Script | ⭐⭐⭐ |
| **OpenAI Codex** | ⚡ Symlink | Auto Script | ⭐⭐⭐ |

**Legend:**
- **✓ Native**: Tool automatically scans or uses the same directory structure
- **⚡ Symlink**: Links to Claude directory for automatic sync

---

## 📦 Skills Included

### 1. **HAP V3 API Usage** ⭐⭐⭐⭐⭐

> Use Mingdao Cloud V3 API for data operations and page development

**Features:**
- Complete API usage workflow
- Full Filter syntax
- Deep querying for related fields
- Common pitfalls and solutions
- Performance optimization

### 2. **HAP View Plugin Development** ⭐⭐⭐⭐⭐

> Create and develop custom view plugins

**Features:**
- 7-step development process
- 4 template options (JS/React/React-Tailwind/Vue)
- Field type handling
- API integration (mdye + V3)
- BI dashboard design guide

### 3. **HAP MCP Usage Guide**

> Configure and manage HAP MCP Server

**Features:**
- MCP Server configuration
- Cursor automated setup
- Credential extraction
- Two MCP types explained

---

## 🎯 Installation Options

```bash
# Install to all platforms
./install.sh --all --global

# Install to specific platforms
./install.sh --claude --trae --cursor --global

# Available options
--all              # All platforms
--global           # Global installation
--project          # Project-level installation
--claude           # Claude Code only
--trae             # TRAE only
--cursor           # Cursor only
--antigravity      # Antigravity only
--windsurf         # Windsurf only
--copilot          # GitHub Copilot only
--opencode         # OpenCode only
--gemini           # Gemini CLI only
--codex            # OpenAI Codex only
```

---

## 📚 Documentation

- **[Quick Start Guide](./docs/QUICK_START.md)** - Get started in 5 minutes
- **[Installation Guide](./docs/INSTALLATION.md)** - Detailed installation for all platforms
- **[Platform Compatibility](./docs/INSTALLATION.md#platform-compatibility)** - Understand platform support

---

## 💡 Best Practice

**"Write Once, Run Everywhere" Strategy:**

1. **Install to Claude** (as central directory)
   ```bash
   ./install.sh --claude --global
   ```

2. **Other native platforms**
   ```bash
   ./install.sh --trae --cursor --antigravity --global
   ```

3. **Symlink platforms** (auto-links to Claude)
   ```bash
   ./install.sh --windsurf --global
   ```

**Result:** Update Claude directory, symlink platforms auto-sync!

---

## ❓ FAQ

### Q: Which platform should I choose?

- **Most Official**: Claude Code (Anthropic official)
- **Most Popular**: Cursor (most users)
- **Standardized**: TRAE (fully standardized directory)
- **Free & Open**: OpenCode (community-driven)

### Q: Can I install to multiple platforms?

**Yes!** One command installs to all 9 platforms:
```bash
./install.sh --all --global
```

### Q: What's special about TRAE?

TRAE uses standardized `.trae/skills/` directory structure:
- ✅ Fully compatible with Claude Code
- ✅ One Skill = One folder in `.trae/skills/`
- ✅ Supports all SKILL.md format features

### Q: How to update skills?

```bash
cd hap-skills-collection
git pull
./install.sh --all --global
```

---

## 🤝 Contributing

We welcome all forms of contributions! Whether it's new skills, documentation improvements, bug fixes, or usage feedback.

### How to Contribute

1. Fork this repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

---

## 💬 Support

- **Bug Reports**: [GitHub Issues](https://github.com/garfield-bb/hap-skills-collection/issues)
- **Feature Requests**: [GitHub Discussions](https://github.com/garfield-bb/hap-skills-collection/discussions)

---

<div align="center">

**If this project helps you, please give us a ⭐️ Star!**

Made with ❤️ by HAP Community

</div>
