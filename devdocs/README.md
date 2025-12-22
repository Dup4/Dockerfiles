# DevDocs 自定义镜像

这是一个精简版的 DevDocs 镜像，只包含以下文档集：

- **C** - C 编程语言
- **C++** - C++ 编程语言
- **Kotlin 1.9** - Kotlin 1.9 版本
- **OpenJDK 21** - OpenJDK 21 版本
- **Python 3.9** - Python 3.9 版本

## 特点

- 基于 Alpine Linux，镜像体积小
- 适合生产部署
- 支持离线使用
- 包含完整的搜索和导航功能
- 支持 amd64 和 arm64 架构

## 快速开始

### 使用预构建镜像

从 Docker Hub 拉取并运行预构建的镜像：

```bash
docker pull dup4/devdocs:latest
docker run --name devdocs -d -p 9292:9292 dup4/devdocs:latest
```

### 本地构建镜像

如果需要自定义或本地构建：

```bash
# 构建默认版本（main 分支）
docker build -t devdocs-custom:latest .

# 构建特定版本
docker build --build-arg DEVDOCS_REF=v2.0.0 -t devdocs-custom:v2.0.0 .

# 运行容器
docker run --name devdocs -d -p 9292:9292 devdocs-custom:latest
```

**DEVDOCS_REF** 参数说明：
- 默认值：`main`（DevDocs 主分支）
- 支持：分支名、标签名、commit SHA
- 示例：`main`, `v2.0.0`, `abc1234`

## 访问

在浏览器中打开：http://localhost:9292

## 自定义文档集

如果需要修改包含的文档集，需要编辑 `Dockerfile` 中的**两处**：

1. **下载文档**（第 22 行）：
```dockerfile
RUN thor docs:download c cpp kotlin~1.9 openjdk~21 python~3.9
```

2. **默认文档配置**（第 26 行）：
```dockerfile
RUN sed -i "s/set :default_docs, %w(css dom html http javascript)/set :default_docs, %w(c cpp kotlin~1.9 openjdk~21 python~3.9)/" lib/app.rb
```

**重要**：两处的文档列表必须保持一致，否则用户首次访问时会看到未下载的文档。

### 可用的文档标识符

- C: `c`
- C++: `cpp`
- Kotlin: `kotlin~1.9`, `kotlin~1.8`, `kotlin~1.7` 等
- OpenJDK: `openjdk~21`, `openjdk~25` 等
- Python: `python~3.9`, `python~3.10`, `python~3.11` 等

要查看所有可用的文档，可以运行：

```bash
docker run --rm ruby:3.4.7-alpine sh -c "apk add git && \
  git clone --depth 1 https://github.com/freeCodeCamp/devdocs.git && \
  cd devdocs && gem install bundler && bundle install && \
  bundle exec thor docs:list"
```

## 停止和删除容器

```bash
# 停止容器
docker stop devdocs

# 删除容器
docker rm devdocs

# 删除镜像
docker rmi devdocs-custom:latest
```

## GitHub Actions 自动构建

本项目配置了 GitHub Actions CI，可以自动构建并推送镜像到 Docker Hub。

### 手动触发构建

1. 进入 GitHub 仓库的 **Actions** 页面
2. 选择 **Build DevDocs** workflow
3. 点击 **Run workflow**
4. 配置参数：
   - **version**: 镜像标签（默认：`latest`）
   - **devdocs_ref**: DevDocs 仓库引用（默认：`main`）
5. 点击 **Run workflow** 开始构建

构建完成后，镜像会自动推送到 Docker Hub: `dup4/devdocs:<version>`

#### 参数说明

- **version**: Docker 镜像的标签名，如 `latest`、`v2.0.0`、`2024-12-21` 等
- **devdocs_ref**: DevDocs 源码仓库的引用，支持：
  - 分支名：`main`, `develop`
  - 标签名：`v2.0.0`, `2024-12-01`
  - Commit SHA：`abc1234`, `abc1234567890abcdef`

#### 使用示例

**示例 1**：构建最新版本
- version: `latest`
- devdocs_ref: `main`

**示例 2**：构建特定版本
- version: `v2.0.0`
- devdocs_ref: `v2.0.0`（假设 DevDocs 有此标签）

**示例 3**：测试特定提交
- version: `test-abc1234`
- devdocs_ref: `abc1234567890abcdef`

### 支持的架构

CI 自动构建以下架构的镜像：
- `linux/amd64` (x86_64)
- `linux/arm64` (ARM64/Apple Silicon)

## 相关链接

- [DevDocs 官网](https://devdocs.io)
- [DevDocs GitHub](https://github.com/freeCodeCamp/devdocs)
- [freeCodeCamp](https://www.freecodecamp.org)
- [Docker Hub](https://hub.docker.com/r/dup4/devdocs)

## 许可证

本项目基于 DevDocs 创建，遵循 DevDocs 的许可证。
