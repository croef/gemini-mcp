# Gemini MCP 服务器

适用于 Google Gemini AI 服务的综合模型上下文协议 (MCP) 服务器，通过 Google 最先进的 AI 模型提供高级多模态生成功能，包括图像生成、图像编辑和视频创作。

## 🚀 功能特性

### **多模态 AI 服务**
- **🖼️ 图像生成**：使用 Gemini 2.5 Flash Image Preview 和 Imagen 4.0 模型进行高质量图像创作
- **✏️ 图像编辑**：使用 Gemini AI 模型进行高级图像修改和增强
- **🔀 多图像合成**：无缝混合和组合多张图像
- **🎬 视频生成**：使用 Google 的 Veo 3.0 模型进行电影级视频创作（文本生成视频和图像生成视频）

### **先进模型支持**
- **Gemini 模型**：`gemini-2.5-flash-image-preview`、`gemini-2.0-flash-preview`
- **Imagen 模型**：`imagen-4.0-generate-001`（最新版）、`imagen-4.0-ultra-generate-001`、`imagen-4.0-fast-generate-001`
- **Veo 模型**：`veo-3.0-generate-001`、`veo-3.0-fast-generate-001`、`veo-2.0-generate-001`

### **MCP 协议功能**
- **Stdio 传输**：直接与 MCP 客户端集成
- **全面的工具描述**：详细的参数文档和使用示例
- **文件输出管理**：可配置的输出目录和元数据
- **错误处理**：强大的错误处理机制，提供有用的响应信息

## 📋 先决条件

- **Go 1.23+**（构建必需）
- **Google API Key**，需要 Gemini API 访问权限（必需）
- **可选**：Google Cloud 项目 ID 用于高级功能

## 🛠️ 安装

### 快速设置

1. **克隆和构建**：
```bash
git clone <repository-url>
cd gemini-mcp
go build -o gemini-mcp main.go
```

2. **设置 API 密钥**：
```bash
export GOOGLE_API_KEY="your_google_api_key_here"
```

3. **测试安装**：
```bash
./gemini-mcp -version
```

### 使用 Makefile

1. **安装依赖**：
```bash
make deps
```

2. **构建应用**：
```bash
make build
```

3. **设置环境**：
```bash
cp .env.example .env
# 编辑 .env 文件，添加您的 API 密钥
```

## 🎯 使用方法

### 命令行界面

```bash
./gemini-mcp [选项]

选项:
  -transport string    传输类型：stdio（默认）
  -version            显示版本信息
```

### Stdio 模式（MCP 集成）

运行服务器以直接与 MCP 客户端集成：
```bash
./gemini-mcp
```

### 测试 MCP 协议

```bash
# 测试基本连接
./test_mcp.sh

# 手动测试
echo '{"jsonrpc":"2.0","id":"1","method":"tools/list","params":{}}' | ./gemini-mcp
```

## 🛠️ 可用工具

### 1. **gemini_image_generation**
使用 Google 最新的 Gemini 图像生成模型生成高质量图像，具备先进的风格控制和质量设置。

**主要功能：**
- 高级风格控制和艺术选项
- 多语言提示支持
- 可定制的纵横比和质量设置
- 内容安全级别和文本渲染选项

**参数：**
- `prompt`（必需）：所需图像的详细描述
- `model`：Gemini 模型变体（默认：`gemini-2.5-flash-image-preview`）
- `output_directory`：本地保存路径

### 2. **gemini_image_edit**
使用 Google 的 Gemini AI 模型编辑现有图像，进行有针对性的修改。

**主要功能：**
- 有针对性的图像修改和风格转换
- 对象添加/删除功能
- 背景更改，同时保留原始特征
- 对编辑类型的精确控制

**参数：**
- `prompt`（必需）：所需编辑的描述
- `image_path`：要编辑的图像路径
- `edit_type`：编辑操作类型
- `output_directory`：本地保存路径

### 3. **gemini_multi_image**
使用 Google 的 Gemini AI 模型组合和混合多张图像。

**主要功能：**
- 将 2-3 张图像合并为统一的构图
- 创建拼贴、叠加和无缝混合
- 跨场景的角色一致性
- 创意构图的风格统一

**参数：**
- `prompt`（必需）：所需构图的描述
- `image_paths`：要组合的图像路径数组
- `blend_mode`：如何组合图像
- `output_directory`：本地保存路径

### 4. **imagen_t2i**
使用 Google 最先进的 Imagen 模型生成高质量图像。

**主要功能：**
- 逼真照片和艺术图像创作
- 多种模型变体适用于不同用例
- 支持各种纵横比
- 批量生成（1-4 张图像）

**参数：**
- `prompt`（必需）：详细的图像描述
- `model`：Imagen 变体（默认：`imagen-4.0-generate-001`）
- `num_images`：图像数量（1-4，默认：1）
- `aspect_ratio`：图像比例（`1:1`、`16:9`、`9:16`、`4:3`、`3:4`）
- `output_directory`：本地保存路径

**支持的模型：**
- `imagen-4.0-generate-001`：最新标准模型
- `imagen-4.0-ultra-generate-001`：最高质量
- `imagen-4.0-fast-generate-001`：最快生成

### 5. **veo_text_to_video**
使用 Google 的 Veo 3.0 模型从文本提示生成 8 秒视频。

**主要功能：**
- 详细的场景描述和摄像机运动
- 真实的物理效果和自然运动
- 支持 16:9/9:16 纵横比
- 720p/1080p 分辨率选项
- 负面提示用于内容排除
- SynthID 水印

**参数：**
- `prompt`（必需）：详细的视频场景描述
- `negative_prompt`：视频中要避免的内容
- `aspect_ratio`：视频比例（`16:9`、`9:16`）
- `resolution`：视频质量（`720p`、`1080p`）
- `model`：Veo 变体（默认：`veo-3.0-generate-001`）
- `seed`：可选的种子值用于可重现性
- `output_directory`：本地保存路径

### 6. **veo_image_to_video**
使用 Google 的 Veo 3.0 模型将静态图像动画化为 8 秒视频。

**主要功能：**
- 将照片转换为动态场景
- 自然运动和摄像机运动
- 输入图像成为起始帧
- 真实的物理模拟

**参数：**
- `prompt`（必需）：所需动画的描述
- `image_path`：输入图像路径
- `negative_prompt`：要避免的内容
- `aspect_ratio`：视频比例（`16:9`、`9:16`）
- `resolution`：视频质量（`720p`、`1080p`）
- `model`：Veo 变体（默认：`veo-3.0-generate-001`）
- `output_directory`：本地保存路径

### 7. **veo_generate_video**（旧版）
通用视频生成工具，支持文本生成视频和图像生成视频创作。

**主要功能：**
- 与现有工作流程的向后兼容性
- 支持文本和图像输入
- 高级场景构图
- 自动操作轮询

**参数：**
- `prompt`（必需）：视频描述
- `image_path`：可选的输入图像（用于图像生成视频）
- `aspect_ratio`：视频比例
- `resolution`：视频质量
- `negative_prompt`：内容排除
- `output_directory`：本地保存路径

## 🔧 环境配置

| 变量 | 描述 | 默认值 | 必需 |
|----------|-------------|---------|----------|
| `GOOGLE_API_KEY` | Gemini API 认证密钥 | - | ✅ 是 |
| `GOOGLE_PROJECT_ID` | Google Cloud 项目 ID | - | ❌ 可选 |
| `GOOGLE_LOCATION` | Google Cloud 区域 | `us-central1` | ❌ 可选 |
| `OUTPUT_DIR` | 文件输出目录 | `./output` | ❌ 可选 |
| `TRANSPORT` | MCP 传输协议 | `stdio` | ❌ 可选 |

## 🔌 MCP 客户端集成

### Claude Desktop 配置
```json
{
  "mcpServers": {
    "gemini": {
      "command": "/path/to/gemini-mcp",
      "env": {
        "GOOGLE_API_KEY": "your_api_key_here"
      }
    }
  }
}
```

### Cline VSCode 扩展
```json
{
  "cline.mcp.servers": [
    {
      "name": "gemini",
      "command": "/path/to/gemini-mcp",
      "env": {
        "GOOGLE_API_KEY": "your_api_key_here"
      }
    }
  ]
}
```

## 🧪 开发

### 从源码构建
```bash
go mod tidy
go build -o gemini-mcp main.go
```

### 测试
```bash
make test
./test_mcp.sh
```

### 代码质量
```bash
make fmt    # 格式化代码
make clean  # 清理构建产物
```

## 📝 实现说明

- **Gemini 集成**：使用 `google.golang.org/genai` 与 Gemini API 后端集成
- **协议合规性**：实现 MCP 2024-11-05 规范
- **图像生成**：完全实现 Gemini 2.5 Flash Image Preview 和 Imagen 4.0 模型
- **视频生成**：完整的 Veo 3.0 集成，支持操作轮询和正确的文件下载
- **文件管理**：生成的内容保存时包含元数据和时间戳
- **错误处理**：全面的错误响应机制，提供有用的错误信息
- **多模态支持**：支持文本生成图像、图像生成图像、文本生成视频和图像生成视频工作流程

## 🤝 贡献

本项目旨在成为 Google AI 服务的综合 MCP 服务器。欢迎为以下方面做出贡献：
- 额外的模型支持
- 传输协议增强
- 占位服务的完整实现
- 文档改进

## 📄 许可证

MIT 许可证 - 详情请参见 LICENSE 文件。