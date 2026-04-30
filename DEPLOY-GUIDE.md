# 🚀 智控科技网站 - 部署指南（2026-03-31 更新）

## 📁 项目文件结构

```
website/
├── index.html                 # 首页（含导航下拉菜单）
├── products-training.html     # 教学培训设备详情页
├── products-flowmeter.html    # 流量计及仪表详情页
├── products-automation.html   # 自动化设备详情页
├── about.html                 # 关于我们
├── style.css                  # 全局样式
├── script.js                  # 交互逻辑
├── products-data.json         # 产品数据（71个产品）
├── seo-config.json            # SEO 配置
├── robots.txt                 # 爬虫规则
├── sitemap.xml                # 站点地图
├── netlify.toml               # Netlify 配置
└── 产品数据源/                 # 原始调研文档（部署时不需要）
```

## 第一步：部署到 Netlify（5 分钟）

### 1.1 注册 Netlify
- 打开 https://app.netlify.com/signup
- 用 **GitHub 账号** 直接登录（推荐），或用邮箱注册

### 1.2 部署网站
1. 登录后，点击 **"Add new site"** → **"Deploy manually"**
2. 把 `website` 文件夹中以下文件打包上传：
   - `index.html`
   - `products-training.html`
   - `products-flowmeter.html`
   - `products-automation.html`
   - `about.html`
   - `style.css`
   - `script.js`
   - `robots.txt`
   - `sitemap.xml`
   - `netlify.toml`
3. Netlify 会自动分配域名，类似：
   `https://random-name-abc123.netlify.app`
4. ✅ **此时网站已上线！**

> **注意：** `.md` 和 `.json` 文件不需要上传到生产环境，但放着也没影响。

## 第二步：绑定自定义域名（可选）

### 方案 A：is-a.dev 免费域名
1. GitHub 账号 → Fork https://github.com/is-a-dev/register
2. 在 `domains/` 下创建 `zktech.json`：
```json
{
  "owner": { "username": "你的GitHub用户名" },
  "records": { "CNAME": "你的Netlify域名.netlify.app" }
}
```
3. 提交 Pull Request，等 1-3 天审核

### 方案 B：购买自有域名
- 推荐阿里云/腾讯云购买 `.com` 或 `.cn` 域名
- 在 Netlify 后台 → Domain management → Add domain
- 按提示配置 DNS 解析

## 第三步：上线前必须修改的内容

| 内容 | 位置 | 占位符 |
|------|------|--------|
| 公司名称 | 全局 | `智控科技`（如果需要改名） |
| 联系电话 | index.html + about.html | `400-888-XXXX` |
| 邮箱地址 | index.html + about.html | `sales@zhikong-tech.com` |
| 微信号 | index.html + about.html | `zhikong-tech` |
| 公司地址 | index.html + about.html | `XX 市 XX 区 XX 路 XX 号` |
| ICP 备案号 | index.html footer | `粤ICP备XXXXXXXX号` |
| 域名 | seo-config.json + sitemap.xml | `zhikongkeji.com` |
| 团队信息 | about.html | 占位姓名和职位 |
| OG 图片 | seo-config.json | `/og-image.png`（需上传实际图片） |

## 🎨 当前功能特性

- ✅ 响应式设计，适配手机/平板/电脑
- ✅ 5 个完整页面（首页 + 3个产品页 + 关于页）
- ✅ 导航栏下拉菜单
- ✅ 深色 Hero 区域 + 网格动画
- ✅ 产品卡片悬停效果
- ✅ 滚动显示动画
- ✅ 导航栏滚动变色
- ✅ 表单提交提示
- ✅ SEO 优化（meta 标签 + 结构化数据 + sitemap）
- ✅ 纯静态，无需服务器
- ✅ 无外部 JS 依赖，加载快

## 🔄 后续优化建议

1. **添加产品图片** — 替换当前纯文字卡片为图文混排
2. **接入表单后端** — Netlify Forms 或 Formspree 处理询价
3. **添加在线客服** — 接入微信客服插件或 Tawk.to
4. **HTTPS** — Netlify 自动提供，无需额外配置
5. **CDN 加速** — Netlify 自带全球 CDN
6. **百度站长平台** — 提交 sitemap 加速收录
