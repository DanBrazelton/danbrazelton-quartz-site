---
publish: true
title: Dan Brazelton
created: 2026-06-22T00:23:02.360Z
modified: 2026-06-22T13:09:04.204Z
---

<style>
/* ---- scoped homepage styles ---- */
.dbz-hero {
  position: relative;
  border-radius: 16px;
  overflow: hidden;
  margin: 0 0 2rem 0;
  background: linear-gradient(135deg, #0b1020 0%, #1a2744 55%, #2b3a67 100%);
  border: 1px solid rgba(255,255,255,0.08);
}
.dbz-hero svg { display: block; width: 100%; height: auto; }
.dbz-hero-text {
  position: absolute; left: 6%; top: 50%; transform: translateY(-50%);
  color: #f4f7ff; max-width: 60%;
}
.dbz-hero-text h1 { margin: 0 0 .4rem 0; font-size: clamp(1.6rem, 4vw, 2.8rem); line-height: 1.05; }
.dbz-hero-text p { margin: 0; opacity: .82; font-size: clamp(.85rem, 1.6vw, 1.05rem); }
.dbz-tag {
  display:inline-block; margin-top:.9rem; padding:.25rem .6rem; font-size:.72rem;
  letter-spacing:.08em; text-transform:uppercase; border-radius:999px;
  background:rgba(120,170,255,.18); color:#cfe0ff; border:1px solid rgba(120,170,255,.3);
}

.dbz-grid {
  display: grid; gap: 1rem;
  grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
  margin: 1.5rem 0;
}
.dbz-card {
  border-radius: 14px; padding: 1.2rem 1.2rem 1.3rem;
  background: var(--lightgray, #f4f5f7);
  border: 1px solid rgba(0,0,0,0.06);
  transition: transform .15s ease, box-shadow .15s ease;
  position: relative; overflow: hidden;
}
.dbz-card:hover { transform: translateY(-3px); box-shadow: 0 10px 28px rgba(0,0,0,.12); }
.dbz-card .ico { width: 38px; height: 38px; margin-bottom: .7rem; }
.dbz-card h3 { margin: 0 0 .35rem 0; font-size: 1.05rem; }
.dbz-card p { margin: 0; font-size: .9rem; opacity: .78; line-height: 1.45; }
.dbz-card .accent { position:absolute; right:-30px; top:-30px; width:90px; height:90px; border-radius:50%; opacity:.12; }

.dbz-meter { margin: 1.6rem 0; }
.dbz-meter h4 { margin: 0 0 .8rem 0; font-size:.8rem; letter-spacing:.1em; text-transform:uppercase; opacity:.6; }
.dbz-bar { margin-bottom:.7rem; }
.dbz-bar .lbl { display:flex; justify-content:space-between; font-size:.85rem; margin-bottom:.25rem; }
.dbz-track { height:8px; border-radius:999px; background:rgba(120,130,160,.18); overflow:hidden; }
.dbz-fill { height:100%; border-radius:999px; background:linear-gradient(90deg,#4f7cff,#7aa2ff); }

@media (prefers-color-scheme: dark) {
  .dbz-card { background: #1c1f26; border-color: rgba(255,255,255,0.07); }
}
</style>

<div class="dbz-hero">
  <svg viewBox="0 0 1200 420" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Topographic hero">
    <defs>
      <radialGradient id="glow" cx="78%" cy="30%" r="60%">
        <stop offset="0%" stop-color="#5b7cff" stop-opacity="0.55"/>
        <stop offset="100%" stop-color="#5b7cff" stop-opacity="0"/>
      </radialGradient>
      <linearGradient id="ridge" x1="0" y1="0" x2="0" y2="1">
        <stop offset="0%" stop-color="#9fc0ff" stop-opacity="0.9"/>
        <stop offset="100%" stop-color="#9fc0ff" stop-opacity="0.15"/>
      </linearGradient>
    </defs>
    <rect width="1200" height="420" fill="none"/>
    <rect width="1200" height="420" fill="url(#glow)"/>
    <!-- topo contour lines (overlanding / maps motif) -->
    <g fill="none" stroke="url(#ridge)" stroke-width="1.4">
      <path d="M0,300 C200,250 350,330 540,290 C760,245 920,320 1200,270"/>
      <path d="M0,330 C200,285 360,360 560,318 C780,272 940,348 1200,300"/>
      <path d="M0,360 C220,318 380,388 580,348 C800,302 960,372 1200,330"/>
      <path d="M0,390 C220,352 400,410 600,372 C820,330 980,398 1200,360"/>
    </g>
    <!-- radio waves (ham radio motif), top-right -->
    <g fill="none" stroke="#cfe0ff" stroke-width="1.6" opacity="0.7">
      <circle cx="1000" cy="120" r="30"/>
      <circle cx="1000" cy="120" r="58"/>
      <circle cx="1000" cy="120" r="86"/>
      <circle cx="1000" cy="120" r="5" fill="#cfe0ff" stroke="none"/>
    </g>
    <!-- waveform (FT8/digital motif) -->
    <g stroke="#7aa2ff" stroke-width="2.2" fill="none" opacity="0.85">
      <path d="M620,150 l12,-26 l12,52 l12,-72 l12,90 l12,-44 l12,30 l12,-18 l12,10"/>
    </g>
  </svg>
  <div class="dbz-hero-text">
    <h1>Dan Brazelton</h1>
    <p>Operations, signals, and a vehicle pointed at the next forest road. A working notebook, published.</p>
    <span class="dbz-tag">Digital Garden · built with Quartz</span>
  </div>
</div>

Welcome. This is a living set of notes — operations and business thinking on one side, radio and the outdoors on the other. Below is a quick map of what lives here.

<div class="dbz-grid">

  <div class="dbz-card">
    <div class="accent" style="background:#4f7cff;"></div>
    <svg class="ico" viewBox="0 0 24 24" fill="none" stroke="#4f7cff" stroke-width="1.8"><path d="M3 3v18h18"/><path d="M7 14l3-4 3 3 5-7"/></svg>
    <h3>Operations & Strategy</h3>
    <p>Cost discipline, CPG go-to-market, and the parts of running a business that actually move numbers.</p>
  </div>

  <div class="dbz-card">
    <div class="accent" style="background:#34c98a;"></div>
    <svg class="ico" viewBox="0 0 24 24" fill="none" stroke="#34c98a" stroke-width="1.8"><circle cx="12" cy="12" r="3"/><circle cx="12" cy="12" r="8"/><path d="M12 1v3M12 20v3M1 12h3M20 12h3"/></svg>
    <h3>Amateur Radio</h3>
    <p>HF and DXing, VHF/UHF weak signal, digital modes, and emergency comms. General class, always tinkering.</p>
  </div>

  <div class="dbz-card">
    <div class="accent" style="background:#e0863a;"></div>
    <svg class="ico" viewBox="0 0 24 24" fill="none" stroke="#e0863a" stroke-width="1.8"><path d="M3 17h2l2-5h10l2 5h2"/><circle cx="7" cy="18" r="2"/><circle cx="17" cy="18" r="2"/><path d="M5 12l2-5h8l3 5"/></svg>
    <h3>Overlanding</h3>
    <p>Field setups, adventure platforms, and the gear that survives a washboard road. Maps and mileage.</p>
  </div>

  <div class="dbz-card">
    <div class="accent" style="background:#c0566f;"></div>
    <svg class="ico" viewBox="0 0 24 24" fill="none" stroke="#c0566f" stroke-width="1.8"><path d="M6 2v20M6 8h6a4 4 0 0 0 0-8H6"/><path d="M14 14h4M16 12v8"/></svg>
    <h3>Kitchen Notes</h3>
    <p>A growing recipe collection — tested, tagged, and occasionally chargrilled.</p>
  </div>

</div>

## What I'm building

This site is itself a demonstration: notes written in Obsidian, synced to a Git repo, and rendered by Quartz onto a Cloudflare-hosted page. The graphics above are inline SVG — no images, no external assets — to show how much you can do with plain Markdown plus a little markup.

<div class="dbz-meter">
  <h4>Currently in rotation</h4>
  <div class="dbz-bar">
    <div class="lbl"><span>Business curriculum</span><span>ongoing</span></div>
    <div class="dbz-track"><div class="dbz-fill" style="width:70%"></div></div>
  </div>
  <div class="dbz-bar">
    <div class="lbl"><span>Recipe system in Obsidian</span><span>building</span></div>
    <div class="dbz-track"><div class="dbz-fill" style="width:55%"></div></div>
  </div>
  <div class="dbz-bar">
    <div class="lbl"><span>Field radio kit</span><span>refining</span></div>
    <div class="dbz-track"><div class="dbz-fill" style="width:80%"></div></div>
  </div>
</div>

## Start here

- **[[Operations & Strategy]]** — the business side
- **[[Amateur Radio]]** — antennas, modes, and field days
- **[[Overlanding]]** — the rig and the routes
- **[[Kitchen Notes]]** — what's cooking

---

_Built with [Quartz](https://quartz.jzha.org/). Notes managed in Obsidian, published via Git._
\</file\_text>
