---
name: doc-to-markdown
description: 把 PDF/Word/Excel/PPT/图片/HTML 等文档转成 Markdown 纯文本，供 agent 读取。需要解析简历、JD、成绩单、附件、任意二进制文档时用。触发词：转markdown、解析这个文件、读这个pdf/docx/xlsx、markitdown、提取文档文字。
---

# doc-to-markdown — 用 markitdown 把任意文档转 Markdown

微软 markitdown 已装（`~/.local/bin/markitdown`，uv 隔离环境，Python 3.12）。
把二进制/富格式文档转成干净 Markdown，让 Claude/Codex 能直接读。

## 何时用
- 要读 PDF / DOCX / XLSX / PPTX / 图片 / HTML / CSV / EPUB 里的文字
- Codex 没有原生读 PDF 能力时，先转 md 再读
- 批量解析简历、JD、成绩单、邮件附件

## 命令
```bash
markitdown 文件.pdf                    # 打印 Markdown 到 stdout
markitdown 文件.docx -o 输出.md         # 存文件
markitdown a.pdf b.xlsx c.pptx         # 多文件
cat 文件.pdf | markitdown              # 管道
```
若 CLI 不在 PATH：`export PATH="$HOME/.local/bin:$PATH"`。

## 支持格式
PDF、Word(docx)、Excel(xlsx/xls)、PowerPoint(pptx)、图片(jpg/png，含OCR/EXIF)、
HTML、CSV/JSON/XML、EPUB、ZIP(递归)、YouTube URL(取字幕)、音频(需ffmpeg，一般用不到)。

## 注意
- 音频转写要 ffmpeg，本机没装——转简历/JD 用不到，忽略那条警告即可
- 纯文本提取，不保证复杂表格版式 100% 还原；关键数字仍以原件为准
- 重装/升级：`uv tool upgrade markitdown`

## 分工
Claude 和 Codex 都可调（纯本地 CLI，无登录态要求）。
