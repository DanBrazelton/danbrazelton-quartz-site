#!/usr/bin/env bash
# apply-nav.sh — adds the custom top nav to danbrazelton.com and pushes to main.
# Run from the ROOT of your quartz repo (the folder containing quartz.config.default.yaml).
set -euo pipefail

if [ ! -f quartz.config.default.yaml ] || [ ! -d quartz ]; then
  echo "ERROR: run this from the root of your quartz repo." >&2
  exit 1
fi

echo "==> Syncing local main to origin/main (this DISCARDS uncommitted local changes)."
read -r -p "    Continue? [y/N] " ans
[ "${ans:-N}" = "y" ] || [ "${ans:-N}" = "Y" ] || { echo "Aborted."; exit 1; }

git fetch origin
git checkout main
git reset --hard origin/main

echo "==> Writing custom nav plugin + config..."

mkdir -p "$(dirname 'quartz-plugins/nav/package.json')"
cat > 'quartz-plugins/nav/package.json' <<'QZNAV_EOF'
{
  "name": "@danbrazelton/nav",
  "version": "1.0.0",
  "description": "Custom top navigation bar for danbrazelton.com",
  "type": "module",
  "license": "MIT",
  "author": "Dan Brazelton",
  "files": ["dist"],
  "exports": {
    ".": {
      "types": "./dist/index.d.ts",
      "import": "./dist/index.js"
    },
    "./components": {
      "types": "./dist/components/index.d.ts",
      "import": "./dist/components/index.js"
    },
    "./package.json": "./package.json"
  },
  "main": "./dist/index.js",
  "types": "./dist/index.d.ts",
  "sideEffects": false,
  "peerDependencies": {
    "preact": "^10.0.0"
  },
  "quartz": {
    "name": "nav",
    "displayName": "Top Nav",
    "category": "component",
    "version": "1.0.0",
    "quartzVersion": ">=5.0.0",
    "dependencies": [],
    "defaultOrder": 50,
    "defaultEnabled": true,
    "defaultOptions": {},
    "components": {
      "Nav": {
        "displayName": "Top Nav",
        "defaultPosition": "beforeBody",
        "defaultPriority": 1
      }
    }
  }
}

QZNAV_EOF

mkdir -p "$(dirname 'quartz-plugins/nav/src/index.ts')"
cat > 'quartz-plugins/nav/src/index.ts' <<'QZNAV_EOF'
export { default as Nav } from "./components/Nav"
export type {
  QuartzComponent,
  QuartzComponentProps,
} from "@quartz-community/types"

QZNAV_EOF

mkdir -p "$(dirname 'quartz-plugins/nav/src/components/index.ts')"
cat > 'quartz-plugins/nav/src/components/index.ts' <<'QZNAV_EOF'
export { default as Nav } from "./Nav"

QZNAV_EOF

mkdir -p "$(dirname 'quartz-plugins/nav/src/components/Nav.tsx')"
cat > 'quartz-plugins/nav/src/components/Nav.tsx' <<'QZNAV_EOF'
import type {
  QuartzComponent,
  QuartzComponentConstructor,
  QuartzComponentProps,
} from "@quartz-community/types"

function classNames(...classes: (string | undefined)[]): string {
  return classes.filter(Boolean).join(" ")
}

// Hand-picked top-level navigation links.
const NAV_LINKS: [string, string][] = [
  ["Home", "/"],
  ["Notes", "/notes"],
  ["Projects", "/projects"],
  ["About", "/about"],
]

const Nav: QuartzComponent = ({ displayClass }: QuartzComponentProps) => {
  return (
    <nav class={classNames(displayClass, "dbz-nav")} aria-label="Primary">
      <ul class="dbz-nav-list">
        {NAV_LINKS.map(([label, href]) => (
          <li class="dbz-nav-item">
            <a class="dbz-nav-link" href={href}>
              {label}
            </a>
          </li>
        ))}
      </ul>
    </nav>
  )
}

Nav.css = `
.dbz-nav {
  width: 100%;
  margin: 0 0 1.5rem 0;
  border-bottom: 1px solid var(--lightgray);
}
.dbz-nav-list {
  list-style: none;
  display: flex;
  flex-wrap: wrap;
  gap: 0.25rem 1.25rem;
  margin: 0;
  padding: 0 0 0.6rem 0;
}
.dbz-nav-item { margin: 0; padding: 0; }
.dbz-nav-link {
  font-family: var(--headerFont, var(--titleFont));
  font-weight: 600;
  font-size: 1rem;
  color: var(--dark);
  text-decoration: none;
  padding: 0.2rem 0;
  border-bottom: 2px solid transparent;
  transition: color 0.15s ease, border-color 0.15s ease;
}
.dbz-nav-link:hover {
  color: var(--secondary);
  border-bottom-color: var(--secondary);
}
`

export default (() => Nav) satisfies QuartzComponentConstructor

QZNAV_EOF

mkdir -p "$(dirname 'quartz-plugins/nav/dist/index.js')"
cat > 'quartz-plugins/nav/dist/index.js' <<'QZNAV_EOF'
// classNames helper (inlined)
function classNames(...classes) {
  return classes.filter(Boolean).join(" ");
}

// preact error-boundary hook + jsx-runtime (inlined, mirrors @quartz-community plugins)
var l;
l = { __e: function(n2, l2, u3, t2) {
  for (var i2, r2, o2; l2 = l2.__; ) if ((i2 = l2.__c) && !i2.__) try {
    if ((r2 = i2.constructor) && null != r2.getDerivedStateFromError && (i2.setState(r2.getDerivedStateFromError(n2)), o2 = i2.__d), null != i2.componentDidCatch && (i2.componentDidCatch(n2, t2 || {}), o2 = i2.__d), o2) return i2.__E = i2;
  } catch (l3) {
    n2 = l3;
  }
  throw n2;
} }, "function" == typeof Promise ? Promise.prototype.then.bind(Promise.resolve()) : setTimeout, Math.random().toString(8);
var f2 = 0;
function u2(e2, t2, n2, o2, i2, u3) {
  t2 || (t2 = {});
  var a2, c2, p2 = t2;
  if ("ref" in p2) for (c2 in p2 = {}, t2) "ref" == c2 ? a2 = t2[c2] : p2[c2] = t2[c2];
  var l2 = { type: e2, props: p2, key: n2, ref: a2, __k: null, __: null, __b: 0, __e: null, __c: null, constructor: void 0, __v: --f2, __i: -1, __u: 0, __source: i2, __self: u3 };
  if ("function" == typeof e2 && (a2 = e2.defaultProps)) for (c2 in a2) void 0 === p2[c2] && (p2[c2] = a2[c2]);
  return l.vnode && l.vnode(l2), l2;
}

// Nav component
var NAV_LINKS = [
  ["Home", "/"],
  ["Notes", "/notes"],
  ["Projects", "/projects"],
  ["About", "/about"]
];
var Nav = ({ displayClass }) => {
  return /* @__PURE__ */ u2("nav", { class: classNames(displayClass, "dbz-nav"), "aria-label": "Primary", children: /* @__PURE__ */ u2("ul", { class: "dbz-nav-list", children: NAV_LINKS.map(([label, href]) => /* @__PURE__ */ u2("li", { class: "dbz-nav-item", children: /* @__PURE__ */ u2("a", { class: "dbz-nav-link", href, children: label }) })) }) });
};
Nav.css = `
.dbz-nav {
  width: 100%;
  margin: 0 0 1.5rem 0;
  border-bottom: 1px solid var(--lightgray);
}
.dbz-nav-list {
  list-style: none;
  display: flex;
  flex-wrap: wrap;
  gap: 0.25rem 1.25rem;
  margin: 0;
  padding: 0 0 0.6rem 0;
}
.dbz-nav-item { margin: 0; padding: 0; }
.dbz-nav-link {
  font-family: var(--headerFont, var(--titleFont));
  font-weight: 600;
  font-size: 1rem;
  color: var(--dark);
  text-decoration: none;
  padding: 0.2rem 0;
  border-bottom: 2px solid transparent;
  transition: color 0.15s ease, border-color 0.15s ease;
}
.dbz-nav-link:hover {
  color: var(--secondary);
  border-bottom-color: var(--secondary);
}
`;
var Nav_default = (() => Nav);

export { Nav_default as Nav };

QZNAV_EOF

mkdir -p "$(dirname 'quartz-plugins/nav/dist/components/index.js')"
cat > 'quartz-plugins/nav/dist/components/index.js' <<'QZNAV_EOF'
// classNames helper (inlined)
function classNames(...classes) {
  return classes.filter(Boolean).join(" ");
}

// preact error-boundary hook + jsx-runtime (inlined, mirrors @quartz-community plugins)
var l;
l = { __e: function(n2, l2, u3, t2) {
  for (var i2, r2, o2; l2 = l2.__; ) if ((i2 = l2.__c) && !i2.__) try {
    if ((r2 = i2.constructor) && null != r2.getDerivedStateFromError && (i2.setState(r2.getDerivedStateFromError(n2)), o2 = i2.__d), null != i2.componentDidCatch && (i2.componentDidCatch(n2, t2 || {}), o2 = i2.__d), o2) return i2.__E = i2;
  } catch (l3) {
    n2 = l3;
  }
  throw n2;
} }, "function" == typeof Promise ? Promise.prototype.then.bind(Promise.resolve()) : setTimeout, Math.random().toString(8);
var f2 = 0;
function u2(e2, t2, n2, o2, i2, u3) {
  t2 || (t2 = {});
  var a2, c2, p2 = t2;
  if ("ref" in p2) for (c2 in p2 = {}, t2) "ref" == c2 ? a2 = t2[c2] : p2[c2] = t2[c2];
  var l2 = { type: e2, props: p2, key: n2, ref: a2, __k: null, __: null, __b: 0, __e: null, __c: null, constructor: void 0, __v: --f2, __i: -1, __u: 0, __source: i2, __self: u3 };
  if ("function" == typeof e2 && (a2 = e2.defaultProps)) for (c2 in a2) void 0 === p2[c2] && (p2[c2] = a2[c2]);
  return l.vnode && l.vnode(l2), l2;
}

// Nav component
var NAV_LINKS = [
  ["Home", "/"],
  ["Notes", "/notes"],
  ["Projects", "/projects"],
  ["About", "/about"]
];
var Nav = ({ displayClass }) => {
  return /* @__PURE__ */ u2("nav", { class: classNames(displayClass, "dbz-nav"), "aria-label": "Primary", children: /* @__PURE__ */ u2("ul", { class: "dbz-nav-list", children: NAV_LINKS.map(([label, href]) => /* @__PURE__ */ u2("li", { class: "dbz-nav-item", children: /* @__PURE__ */ u2("a", { class: "dbz-nav-link", href, children: label }) })) }) });
};
Nav.css = `
.dbz-nav {
  width: 100%;
  margin: 0 0 1.5rem 0;
  border-bottom: 1px solid var(--lightgray);
}
.dbz-nav-list {
  list-style: none;
  display: flex;
  flex-wrap: wrap;
  gap: 0.25rem 1.25rem;
  margin: 0;
  padding: 0 0 0.6rem 0;
}
.dbz-nav-item { margin: 0; padding: 0; }
.dbz-nav-link {
  font-family: var(--headerFont, var(--titleFont));
  font-weight: 600;
  font-size: 1rem;
  color: var(--dark);
  text-decoration: none;
  padding: 0.2rem 0;
  border-bottom: 2px solid transparent;
  transition: color 0.15s ease, border-color 0.15s ease;
}
.dbz-nav-link:hover {
  color: var(--secondary);
  border-bottom-color: var(--secondary);
}
`;
var Nav_default = (() => Nav);

export { Nav_default as Nav };

QZNAV_EOF

mkdir -p "$(dirname 'quartz-plugins/nav/dist/index.d.ts')"
cat > 'quartz-plugins/nav/dist/index.d.ts' <<'QZNAV_EOF'
import type { QuartzComponentConstructor } from "@quartz-community/types";
declare const _default: QuartzComponentConstructor;
export { _default as Nav };

QZNAV_EOF

mkdir -p "$(dirname 'quartz-plugins/nav/dist/components/index.d.ts')"
cat > 'quartz-plugins/nav/dist/components/index.d.ts' <<'QZNAV_EOF'
import type { QuartzComponentConstructor } from "@quartz-community/types";
declare const _default: QuartzComponentConstructor;
export { _default as Nav };

QZNAV_EOF

mkdir -p "$(dirname 'quartz.config.yaml')"
cat > 'quartz.config.yaml' <<'QZNAV_EOF'
# yaml-language-server: $schema=./quartz/plugins/quartz-plugins.schema.json
configuration:
  pageTitle: Dan Brazelton
  pageTitleSuffix: ""
  enableSPA: true
  enablePopovers: true
  analytics:
    provider: plausible
  locale: en-US
  baseUrl: danbrazelton.com
  ignorePatterns:
    - private
    - templates
    - .obsidian
  theme:
    fontOrigin: googleFonts
    cdnCaching: true
    typography:
      header: Schibsted Grotesk
      body: Source Sans Pro
      code: IBM Plex Mono
    colors:
      lightMode:
        light: "#faf8f8"
        lightgray: "#e5e5e5"
        gray: "#b8b8b8"
        darkgray: "#4e4e4e"
        dark: "#2b2b2b"
        secondary: "#284b63"
        tertiary: "#84a59d"
        highlight: rgba(143, 159, 169, 0.15)
        textHighlight: "#fff23688"
      darkMode:
        light: "#161618"
        lightgray: "#393639"
        gray: "#646464"
        darkgray: "#d4d4d4"
        dark: "#ebebec"
        secondary: "#7b97aa"
        tertiary: "#84a59d"
        highlight: rgba(143, 159, 169, 0.15)
        textHighlight: "#b3aa0288"
plugins:
  - source: github:quartz-community/created-modified-date
    enabled: true
    options:
      defaultDateType: modified
      priority:
        - frontmatter
        - git
        - filesystem
    order: 10
  - source: github:quartz-community/syntax-highlighting
    enabled: true
    options:
      theme:
        light: github-light
        dark: github-dark
      keepBackground: false
    order: 20
  - source: github:quartz-community/obsidian-flavored-markdown
    enabled: true
    options:
      comments: true
      highlight: true
      wikilinks: true
      callouts: true
      mermaid: true
      parseTags: true
      parseArrows: true
      parseBlockReferences: true
      enableInHtmlEmbed: false
      enableYouTubeEmbed: true
      enableVideoEmbed: true
      enableCheckbox: true
    order: 30
  - source: github:quartz-community/github-flavored-markdown
    enabled: true
    order: 40
  - source: github:quartz-community/table-of-contents
    enabled: true
    order: 50
    layout:
      position: right
      priority: 30
  - source: github:quartz-community/crawl-links
    enabled: true
    options:
      markdownLinkResolution: shortest
    order: 60
  - source: github:quartz-community/description
    enabled: true
    order: 70
  - source: github:quartz-community/latex
    enabled: true
    options:
      renderEngine: katex
    order: 80
  - source: github:quartz-community/citations
    enabled: false
    order: 85
  - source: github:quartz-community/hard-line-breaks
    enabled: true
    order: 90
  - source: github:quartz-community/ox-hugo
    enabled: false
    order: 91
  - source: github:quartz-community/roam
    enabled: false
    order: 92
  - source: github:quartz-community/fonts
    enabled: true
  - source: github:quartz-community/remove-draft
    enabled: true
  - source: github:quartz-community/explicit-publish
    enabled: false
  - source: github:quartz-community/unlisted-pages
    enabled: true
    options: {}
    order: 45
  - source: github:quartz-community/encrypted-pages
    enabled: true
    options:
      iterations: 600000
      passwordField: password
      unlistWhenEncrypted: false
      outputPath: static/encryptedContentIndex.json
  - source: github:quartz-community/stacked-pages
    enabled: false
    layout:
      position: afterBody
      priority: 50
      display: all
  - source: github:quartz-community/alias-redirects
    enabled: true
  - source: github:quartz-community/content-index
    enabled: true
    options:
      enableSiteMap: true
      enableRSS: true
  - source: github:quartz-community/favicon
    enabled: true
  - source: github:quartz-community/og-image
    enabled: true
  - source: github:quartz-community/cname
    enabled: true
  - source: github:quartz-community/canvas-page
    enabled: true
  - source: github:quartz-community/content-page
    enabled: true
  - source: github:quartz-community/folder-page
    enabled: true
  - source: github:quartz-community/tag-page
    enabled: true
  - source: github:quartz-community/explorer
    enabled: false
    layout:
      position: left
      priority: 50
  - source: github:quartz-community/graph
    enabled: true
    layout:
      position: right
      priority: 10
  - source: github:quartz-community/search
    enabled: true
    layout:
      position: left
      priority: 20
      group: toolbar
      groupOptions:
        grow: true
  - source: github:quartz-community/backlinks
    enabled: true
    layout:
      position: right
      priority: 50
  - source: github:quartz-community/article-title
    enabled: true
    layout:
      position: beforeBody
      priority: 10
  - source: github:quartz-community/content-meta
    enabled: true
    layout:
      position: beforeBody
      priority: 20
  - source: github:quartz-community/tag-list
    enabled: false
    layout:
      position: beforeBody
      priority: 30
  - source: github:quartz-community/page-title
    enabled: false
    layout:
      position: left
      priority: 10
  - source: github:quartz-community/darkmode
    enabled: true
    layout:
      position: left
      priority: 30
      group: toolbar
  - source: github:quartz-community/reader-mode
    enabled: true
    layout:
      position: left
      priority: 35
      group: toolbar
  - source: github:quartz-community/breadcrumbs
    enabled: true
    layout:
      position: beforeBody
      priority: 5
      condition: not-index
  - source: github:quartz-community/comments
    enabled: false
    options:
      provider: giscus
      options: {}
    layout:
      position: afterBody
      priority: 10
  - source: github:quartz-community/footer
    enabled: true
    options:
      links:
        GitHub: https://github.com/jackyzha0/quartz
        Discord Community: https://discord.gg/cRFFHYye7t
  - source: github:quartz-community/recent-notes
    enabled: false
  - source: github:quartz-community/spacer
    enabled: true
    options: {}
    order: 25
    layout:
      position: left
      priority: 25
      display: mobile-only
  - source: github:quartz-community/bases-page
    enabled: true
    options: {}
    order: 50
  - source: github:quartz-community/note-properties
    enabled: true
    options:
      includeAll: false
      includedProperties:
        - description
        - tags
        - aliases
      excludedProperties: []
      hidePropertiesView: false
      delimiters: ---
      language: yaml
    order: 5
    layout:
      position: beforeBody
      priority: 15
      display: all
  - source:
      name: quartz-themes
      repo: github:saberzero1/quartz-themes
      subdir: plugin
    enabled: true
    options:
      theme: default
  - source: github:quartz-community/obsidian-plugin-excalidraw
    enabled: true
    options:
      enableInteraction: true
      darkMode: auto
      exportPadding: 20
    order: 50
  - source: ./quartz-plugins/nav
    enabled: true
    layout:
      position: beforeBody
      priority: 1
      display: all
layout:
  groups:
    toolbar:
      priority: 35
      direction: row
      gap: 0.5rem
  byPageType:
    "404":
      positions:
        beforeBody: []
        left: []
        right: []
    content: {}
    folder:
      exclude:
        - reader-mode
      positions:
        right: []
    tag:
      exclude:
        - reader-mode
      positions:
        right: []
    canvas: {}
    bases: {}

QZNAV_EOF


echo "==> Staging, committing, pushing..."
git add quartz-plugins/nav quartz.config.yaml
git commit -m "feat: custom top nav (Home/Notes/Projects/About); disable explorer & page-title; set pageTitle"
git push origin main

echo "==> Done. Cloudflare will build from this push. Watch the deploy; if it fails, run: git revert HEAD && git push"
