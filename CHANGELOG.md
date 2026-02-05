# Changelog

All notable changes to HAP Skills Collection will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.2.0] - 2026-02-05

### Added
- **新技能**: 添加 `coo-social-media` - COO 社交媒体运营技能
- **新技能**: 添加 `hap-api-doc-updater` - HAP API 文档更新器
- **新技能**: 添加 `social-media-automation` - 社交媒体自动化运营
- **新技能**: 添加 `social-media-pro` - 专业社交媒体运营技能
- **新技能**: 添加 `wechat-article-writer` - 微信公众号文章写作
- **新技能**: 添加 `skill-creator` - 技能创建和打包工具
- **新技能**: 添加 `skills/pptx` - PowerPoint 文档处理技能
- **文档**: 为 `hap-v3-api` 添加完整的开发工作流文档
  - `DEVELOPMENT_WORKFLOW.md` - 开发工作流程
  - `MCP_WORKFLOW.md` - MCP 工作流程
  - `README.md` - 技能使用说明
  - `UPDATE_SUMMARY.md` - 更新摘要
  - `references/hap-api-usage-guide.md` - API 使用指南
- **文档**: 为 `hap-view-plugin` 添加完整的开发文档
  - `README.md` - 插件开发指南
  - `V3_API_INTEGRATION.md` - V3 API 集成说明
  - `references/field-type-guide.md` - 字段类型指南
  - `references/hap-view-plugin-dev-guide.md` - 插件开发详细指南
- **脚本**: 为 `hap-view-plugin` 添加开发辅助脚本
  - `scripts/generate-unique-id.sh` - 生成唯一 ID
  - `scripts/init-hap-view-project.sh` - 初始化项目
  - `scripts/quick-start.sh` - 快速启动
  - `scripts/test-mdye-check.sh` - 测试检查

### Changed
- **hap-mcp-usage**: 更新 MCP 配置技能
  - 简化平台识别流程，改为询问用户当前使用的工具
  - 更新所有平台的配置文件路径
  - 增强连通性验证和失败诊断功能
- **hap-v3-api**: 更新技能文档和参考资料
- **hap-view-plugin**: 更新技能文档和开发工具

### Fixed
- **MCP 配置路径**: 修正所有平台的 MCP 配置文件路径
  - GitHub Copilot: `~/.copilot/mcp-config.json`
  - Antigravity: `~/.gemini/antigravity/mcp_config.json`
  - OpenCode: `~/.config/opencode/opencode.json`
  - Windsurf: `~/.codeium/windsurf/mcp_config.json`
  - Gemini CLI: `settings.json` (工具管理)

## [2.1.0] - 2026-01-XX

### Added
- **多产品线支持**: 添加 HAP 多产品线支持说明
  - 明道云 HAP: `https://api.mingdao.com`
  - Nocoly HAP: `https://www.nocoly.com`
  - 私有部署 HAP: `https://your-domain.com/api`
- **新技能**: 添加 `hap-frontend-project` - HAP 前端项目搭建技能
- **MCP 优化**: 添加 MCP vs API 优先级指南到 hap-v3-api skill
- **平台检测**: 优化 MCP 平台检测逻辑 - 优先检测当前运行的 IDE

### Changed
- **MCP 配置**: 添加 MCP 平台自动识别、连通性验证和兼容性反馈机制
- **Antigravity 支持**: 添加 Google Antigravity 平台的 MCP 自动化配置详细步骤
- **AI 执行指南**: 为 hap-view-plugin 添加 AI 助手执行指南

### Fixed
- **MCP 配置**: 修复 MCP 配置致命问题 - 增量更新和连通性验证增强
- **技能列表**: 更新英文 README，移除不存在的技能引用

## [2.0.0] - 2026-01-XX

### Added
- **hap-skills-updater**: 添加自动检查和安装 HAP API 文档 MCP
- **多平台支持**: 添加 Manus 和 Coze 平台的 MCP 自动化安装支持

### Changed
- **内部工具**: 标注 hap-skills-updater 为内部工具

---

## 版本说明

- **Major version (X.0.0)**: 重大架构变更或不兼容的 API 变更
- **Minor version (0.X.0)**: 新增功能，向后兼容
- **Patch version (0.0.X)**: Bug 修复，向后兼容

## 贡献者

感谢所有为 HAP Skills Collection 做出贡献的开发者！

特别感谢 Claude Sonnet 4.5 在技能开发和文档编写中的协助。
