---
name: daily-job-review
description: 邹浩文每日求职日报收网流程：汇总五条采集线产出→四道闸→评分→一张日报推送手机。触发词：出日报、daily review、今天的岗位、收网。定时任务与手动均可触发。
---

# Daily Job Review — 每日收网日报

## 收网源（只汇总，不重复采集）

1. 求职主表（Google Sheets 唯一版，Drive连接器读取）——状态变化、待办、Codex②16:00写入的新岗
2. 领英雷达输出：`/Users/zhw/Claude code/automation/linkedin_radar/`（读最新产出+cron.log）
3. Codex 报告：`/Users/zhw/Documents/邹浩文简历/niuke_auto/reports/` 与 `outputs/`（当日 summary/candidates）
4. `~/job-search-system/inbox/manual-job-links.txt`（用户随手丢的链接，处理后清空归档）
5. 飞书大表增量（每周一次，Chrome扩展筛选+截图解析；对照主表去重后才进闸）

## 流程

收网 → job-eligibility-gate 四道闸 → job-fit-and-tailor 评分（90线）→ 生成日报 → 写 `~/job-search-system/outputs/daily-briefs/<日期>.md` → PushNotification 推送摘要到手机。

## 日报格式（一张纸原则）

```
📋 求职日报 <日期>
── 今日推荐（90+，各带：分数/理由/风险/应届影响/🚀快线标/简历版本/HR私信/链接）
── ⏰ 倒计时（测评/面试/截止，48小时内的置顶加粗——历史上已废3个测评，红线）
── 📬 状态变化（HR已查看/约面/拒绝，来自主表+Gmail回执）
── 🔧 产线健康（雷达/Codex①②/昨日日报 四条线是否真跑了；静默失败立即报警）
── ✅ 待你动作（勾选投递清单 + 需要人工的事项）
```

## 纪律

- 投递发送永远用户手动；日报只备料（话术+链接+开页指引）
- 用户勾选后：按 job-fit-and-tailor 分层备料 → john-profile-guard 核查 → （高分岗）Codex 二审 → 交付
- 用户确认已投后回写主表（重生成流程，不直接改格）；「已投递」状态只有用户确认后才能写
- 推送失败或 Remote Control 断线时：日报照常落盘，用户回来看文件
- 停止条件：用户说「找到工作了/停」即停用定时任务
