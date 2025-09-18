# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-09-18

### 🎉 Initial Release

This is the first stable release of the Gemini MCP Server, providing comprehensive multimodal AI generation capabilities through Google's advanced AI models.

### ✨ Features Added

#### 🖼️ Image Generation & Editing
- **gemini_image_generation** - High-quality image generation using Gemini 2.5 Flash Image Preview
  - Advanced style control and artistic options
  - Multi-language prompt support
  - Customizable aspect ratios and quality settings
  - Content safety levels and text rendering options

- **gemini_image_edit** - Targeted image modification using Gemini AI
  - Object addition/removal capabilities
  - Background changes while preserving characteristics
  - Style transfers and precise edit control

- **gemini_multi_image** - Multi-image composition and blending
  - Merge 2-3 images into cohesive compositions
  - Character consistency across scenes
  - Creative collages and seamless blends

- **imagen_t2i** - Professional text-to-image with Imagen 4.0
  - Multiple model variants (standard, ultra, fast)
  - Batch generation (1-4 images)
  - Various aspect ratios support

#### 🎬 Video Generation
- **veo_text_to_video** - Text-to-video with Veo 3.0
  - 8-second high-quality video generation
  - 720p/1080p resolution options
  - 16:9 and 9:16 aspect ratio support
  - Negative prompts for content exclusion
  - SynthID watermarking

- **veo_image_to_video** - Image animation with Veo 3.0
  - Transform static photos into dynamic scenes
  - Natural motion and camera movements
  - Realistic physics simulation

- **veo_generate_video** - Legacy video generation (backward compatibility)
  - Supports both text-to-video and image-to-video
  - Advanced scene composition
  - Automatic operation polling

#### 🏗️ Infrastructure & DevOps
- **Complete CI/CD Pipeline** with GitHub Actions
  - Automated testing across Go 1.21, 1.22, 1.23
  - Multi-platform builds (Linux/macOS/Windows, amd64/arm64)
  - Automated releases with asset generation
  - Code quality checks and test coverage

- **Docker Containerization**
  - Multi-stage builds for optimized images
  - Security-focused minimal runtime
  - Support for multiple architectures
  - Health checks and proper signal handling

- **Version Management**
  - Build-time version injection
  - Git commit tracking
  - Automated changelog generation

#### 📚 Documentation
- **Comprehensive English Documentation** (README.md)
- **Complete Chinese Translation** (README_zh.md)
- **Development Guide** (CLAUDE.md)
- **Requirements Specification** (require.md)

#### 🔧 Technical Features
- **MCP 2024-11-05 Specification** compliance
- **Google Gemini API Integration** using official Go SDK
- **Environment-based Configuration** with validation
- **Comprehensive Error Handling** with informative messages
- **Secure API Key Management** with .env support
- **Cross-platform Compatibility** (Linux/macOS/Windows)

### 🛠️ Technical Stack
- **Go 1.23+** with modern build practices
- **Google GenAI SDK** (`google.golang.org/genai`)
- **MCP Go SDK** (`github.com/modelcontextprotocol/go-sdk`)
- **Environment Variables** for configuration
- **Docker** with multi-stage builds
- **GitHub Actions** for CI/CD

### 📁 Project Structure
```
gemini-mcp/
├── .github/workflows/     # CI/CD automation
├── internal/              # Internal packages
│   └── common/           # Configuration management
├── pkg/types/            # MCP protocol types
├── main.go               # Main application
├── Dockerfile            # Container definition
├── Makefile              # Build automation
├── README.md             # English documentation
├── README_zh.md          # Chinese documentation
└── CLAUDE.md             # Development guide
```

### 🚀 Quick Start

1. **Installation**
   ```bash
   # Download from releases or build from source
   git clone https://github.com/croef/gemini-mcp.git
   cd gemini-mcp
   make build
   ```

2. **Configuration**
   ```bash
   export GOOGLE_API_KEY="your_gemini_api_key"
   ```

3. **Usage**
   ```bash
   ./build/gemini-mcp  # Run in MCP stdio mode
   ```

### 🔗 MCP Client Integration

#### Claude Desktop
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

### 🌟 Highlights
- **7 Powerful AI Tools** for comprehensive multimodal generation
- **Production Ready** with full CI/CD pipeline
- **Multi-platform Support** across all major operating systems
- **Containerized Deployment** with Docker
- **Comprehensive Documentation** in multiple languages
- **Security First** with proper API key management

### 📈 Performance
- **Efficient Build** with CGO disabled for static binaries
- **Minimal Docker Images** using scratch base
- **Fast Startup** with optimized initialization
- **Memory Efficient** with proper resource management

### 🔒 Security
- **API Key Protection** via environment variables
- **Minimal Attack Surface** with scratch containers
- **Input Validation** for all tool parameters
- **Secure Defaults** for all configurations

---

**Full Changelog**: https://github.com/croef/gemini-mcp/commits/v1.0.0