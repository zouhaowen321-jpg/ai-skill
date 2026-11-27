# Browser Extraction Snippets

Tested 2026-11-27 in Claude Code's built-in Browser pane (`mcp__Claude_Browser__javascript_tool`, REPL style: top-level `await` works, last expression is returned). For a function-style tool (e.g. chrome-devtools `evaluate_script`), pass the inner `async () => { ... }` instead of the outer `await (...)()`.

All snippets only read what the page already rendered or loaded. None of them call Douyin APIs, generate signatures, or touch cookies.

## 1. Metadata: the page's own `aweme/detail` response

After the video page loads, list network requests matching `web/aweme/detail` and read the body of the one with status 200 (a first 403 is normal — the page retries by itself). Do not re-fetch or replay that URL.

If the network list is empty (common right after a `v.douyin.com` short-link redirect), navigate once more to `https://www.douyin.com/video/<aweme_id>`, wait ~3 s, and list again.

Fields to take from `aweme_detail`:

| Field | Use |
|---|---|
| `aweme_id` | `video_id` |
| `desc` / `caption` | `## Caption` (verbatim) |
| `author.nickname`, `author.sec_uid` | author fields |
| `create_time` (unix seconds) | `publish_time`, convert to Asia/Shanghai |
| `duration` (ms) | `duration_sec` |
| `chapter_abstract`, `chapter_list[].desc / detail / timestamp` (ms) | `## Chapters`, and the timestamps to sample frames at |
| `video.subtitle_infos` | platform subtitles, if present |
| `statistics` | stats (the response body may be cut off before it — use snippet 2 instead) |

## 2. Stats and visible comments from the page

```js
(() => {
  const pick = s => document.querySelector(`[data-e2e="${s}"]`)?.innerText.trim();
  return {
    likes: pick('video-player-digg'),
    comments: pick('feed-comment-icon'),
    collects: pick('video-player-collect'),
    shares: pick('video-player-share'),
    textTracks: document.querySelector('video')?.textTracks.length ?? 0,
    topComments: [...document.querySelectorAll('[data-e2e="comment-item"]')]
      .slice(0, 10)
      .map(e => e.innerText.replace(/\s+/g, ' ').slice(0, 200)),
  };
})()
```

Stats come back as display strings (`4.3万`); keep them as shown or convert `万` × 10000. Comments: only what is rendered (usually 5–10); if 0, wait 2–3 s and run again.

## 3. Frame reader (on-screen text, burned-in subtitles, steps)

Set up once per video page. It pauses and mutes the main video and adds a full-screen overlay; frames are drawn onto canvases inside the page. Nothing is downloaded or written to disk — you read each frame from a screenshot.

```js
await (async () => {
  document.getElementById('__frames')?.remove();
  const v = [...document.querySelectorAll('video')]
    .filter(x => x.duration > 0)
    .sort((a, b) => b.offsetWidth * b.offsetHeight - a.offsetWidth * a.offsetHeight)[0];
  if (!v) return { error: '页面上还没有可用的视频，稍等再试' };
  v.muted = true; v.pause();
  const W = v.videoWidth, H = v.videoHeight;
  const box = document.createElement('div');
  box.id = '__frames';
  box.style.cssText = 'position:fixed;inset:0;z-index:2147483647;background:#000;display:none;gap:4px';
  document.body.appendChild(box);
  const seek = t => new Promise(res => {
    if (Math.abs(v.currentTime - t) < 0.05) return res();
    const done = () => { clearTimeout(timer); res(); };
    const timer = setTimeout(done, 5000);
    v.addEventListener('seeked', done, { once: true });
    v.currentTime = t;
  });
  window.__frames = async (times, crop) => {
    box.innerHTML = '';
    box.style.display = 'grid';
    box.style.gridTemplateColumns = times.length > 1 ? '1fr 1fr' : '1fr';
    box.style.gridTemplateRows = times.length > 2 ? '1fr 1fr' : '1fr';
    const [sx, sy, sw, sh] = crop || [0, 0, W, H];
    for (const t of times) {
      await seek(Math.min(t, v.duration - 0.1));
      await new Promise(r => setTimeout(r, 150));
      const wrap = document.createElement('div');
      wrap.style.cssText = 'position:relative;min-height:0;min-width:0';
      const c = document.createElement('canvas');
      c.width = sw; c.height = sh;
      c.style.cssText = 'width:100%;height:100%;object-fit:contain';
      c.getContext('2d').drawImage(v, sx, sy, sw, sh, 0, 0, sw, sh);
      const tag = document.createElement('div');
      tag.textContent = 't=' + t + 's';
      tag.style.cssText = 'position:absolute;left:6px;top:4px;color:#ff0;font:bold 20px sans-serif;background:#000a;padding:2px 6px';
      wrap.append(c, tag);
      box.appendChild(wrap);
    }
    return { shown: times, crop: crop || null };
  };
  window.__framesOff = () => box.remove();
  return { duration: Math.round(v.duration), size: [W, H] };
})()
```

Then, repeatedly:

```js
await __frames([11, 14, 27, 48])          // up to 4 timestamps (seconds) → 2×2 grid, then take a screenshot
await __frames([20], [0, 0, 640, 360])    // one frame, cropped to [x, y, w, h] in video pixels → zoom in on small text
__framesOff()                              // remove the overlay when done
```

Sampling plan:

1. Chapter timestamps first (from `chapter_list`, ms → s, plus ~3 s after each).
2. Then every 2 s across the video, 4 frames per screenshot. Text that stays on screen shows up in several frames — record it once.
3. Crop into any frame whose text is too small to read (prompts, menu paths, settings values). Halving width and height (quarter crop) is usually enough.

A 2-minute video is roughly 15–20 grid screenshots plus a few crops. For videos over ~5 minutes, do the chapter timestamps first and tell the user the full pass will take many screenshots before continuing.

If the overlay is gone after a navigation or page refresh, run the setup snippet again.
