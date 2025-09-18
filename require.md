# Gemini MCP 项目需求

## 项目概述

使用 `https://pkg.go.dev/google.golang.org/genai` 库开发一个 Gemini 的 MCP (Model Context Protocol) 服务器。

## 核心功能要求

### 支持的 AI 服务

1. **Gemini Flash 图片生成** - 使用 Gemini Flash 模型生成图片
2. **TTS (文本转语音)** - 文本到语音转换功能
3. **Imagen** - Google Imagen 图片生成模型
4. **Veo** - Google Veo 视频生成模型
5. **Lyria** - Google Lyria 音乐生成模型

### 传输协议支持

MCP 服务器需要支持多种传输协议：

1. **stdio** - 标准输入输出，可直接使用编译好的二进制运行
2. **SSE (Server-Sent Events)** - 服务器发送事件
3. **HTTP** - HTTP 传输协议

### 资源管理

- **文件目录形式** - 资源文件使用文件目录的形式传递
- **输出目录配置** - 生成的内容保存到可配置的输出目录
- **MCP 资源接口** - 通过 MCP 资源接口访问生成的文件

## 技术要求

### 使用的库和API

- **主要SDK**: `google.golang.org/genai` - 使用 Gemini API SDK（不是 Vertex AI）
- **MCP实现**: 参考 `github.com/GoogleCloudPlatform/vertex-ai-creative-studio/experiments/mcp-genmedia/` 项目的组织形式和架构
- **重要**: 不直接复制 mcp-genmedia 项目，因为它使用 Vertex AI API，我们要使用 Gemini API SDK

### 项目架构参考

参考 mcp-genmedia 项目的：
1. **组织形式** - 项目结构和模块划分
2. **架构设计** - MCP 协议实现方式
3. **工具注册** - 工具的注册和管理方式
4. **传输协议** - 多种传输协议的支持
5. **配置管理** - 环境变量和配置管理
6. **错误处理** - 错误处理和日志记录

### 环境配置

- **GOOGLE_API_KEY** - Gemini API 密钥（必需）
- **GOOGLE_PROJECT_ID** - Google Cloud 项目ID（可选）
- **GOOGLE_LOCATION** - Google Cloud 区域（默认: us-central1）
- **OUTPUT_DIR** - 输出目录（默认: ./output）
- **TRANSPORT** - 传输协议（默认: stdio）
- **PORT** - 服务器端口（SSE/HTTP 模式使用）

## 实现优先级

1. ✅ **基础MCP协议实现** - stdio 传输，基本工具注册
2. ✅ **Gemini Flash 图片生成** - 核心功能实现
3. ✅ **Imagen 集成** - 图片生成功能
4. 🔄 **配置和架构优化** - 参考 mcp-genmedia 项目架构
5. ⏳ **HTTP/SSE 传输支持** - 多传输协议
6. ⏳ **TTS 功能** - 文本转语音
7. ⏳ **Veo 视频生成** - 视频生成功能
8. ⏳ **Lyria 音乐生成** - 音乐生成功能
9. ⏳ **Prompts 支持** - MCP prompts 接口
10. ⏳ **完善错误处理和日志**

## 当前状态

- ✅ 基础项目结构已建立
- ✅ 使用 `google.golang.org/genai` 库
- ✅ 基本的 stdio MCP 协议实现
- ✅ Gemini 文本生成（作为图片描述生成）
- ✅ Imagen 图片生成集成
- 🔄 正在参考 mcp-genmedia 项目优化架构

## 备注

- 优先使用 Gemini API 而非 Vertex AI API
- 保持与 MCP 协议的兼容性
- 确保生成的文件可通过 MCP 资源接口访问
- 支持编译为独立二进制文件运行