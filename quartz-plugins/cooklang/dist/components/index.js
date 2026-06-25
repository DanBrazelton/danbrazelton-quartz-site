// quartz-plugins/cooklang/src/components/Cooklang.tsx
var SCRIPT = String.raw`
(function () {
  function frac(s) {
    if (s.indexOf('/') > -1) { var p = s.split('/'); return parseFloat(p[0]) / parseFloat(p[1]); }
    return parseFloat(s);
  }
  function fmt(n) { return Number(n.toFixed(2)); }
  function getBase(raw) {
    var m = raw.match(/>>\s*servings:\s*([0-9.]+)/i);
    return m ? parseFloat(m[1]) : 4;
  }
  function rawText(code) {
    var lines = code.querySelectorAll('.line');
    if (lines.length > 1) {
      var a = [];
      lines.forEach(function (l) { a.push(l.textContent); });
      return a.join('\n');
    }
    return code.textContent || '';
  }
  function langOf(code) {
    var cls = (code.className || '') + ' ' + ((code.closest('pre') || {}).className || '');
    var holder = code.closest('[data-language]');
    var dl = holder ? (holder.getAttribute('data-language') || '') : '';
    return cls + ' ' + dl;
  }
  function looksCook(code) {
    if (/cooklang/i.test(langOf(code))) return true;
    return /@[^{\s][^{]*\{[^}]*\}/.test(rawText(code));
  }
  function el(tag, cls, txt) {
    var e = document.createElement(tag);
    if (cls) e.className = cls;
    if (txt != null) e.textContent = txt;
    return e;
  }
  function build(raw) {
    var base = getBase(raw);
    var card = el('div', 'cooklang-card');

    var ingRe = /@([^{]+)\{([^%}]+)?(?:%([^}]+))?\}/g, m, uniq = {}, order = [];
    while ((m = ingRe.exec(raw)) !== null) {
      var name = m[1].trim(), rawAmt = m[2] ? m[2].trim() : '', unit = m[3] ? m[3].trim() : '';
      var amt = NaN;
      if (rawAmt.indexOf('-') > -1) { amt = NaN; }
      else if (rawAmt.indexOf('/') > -1) { amt = frac(rawAmt); }
      else if (rawAmt !== '') { amt = parseFloat(rawAmt); }
      var key = name + '_' + unit;
      if (uniq[key]) { if (!isNaN(amt) && !isNaN(uniq[key].amt)) uniq[key].amt += amt; }
      else { uniq[key] = { name: name, amt: amt, rawAmt: rawAmt, unit: unit }; order.push(key); }
    }

    card.appendChild(el('h3', 'cooklang-h', 'Ingredients'));
    var ctrl = el('div', 'cooklang-scale');
    ctrl.appendChild(el('span', 'cooklang-scale-label', 'Servings'));
    var slider = document.createElement('input');
    slider.type = 'range'; slider.min = '1'; slider.max = '24';
    slider.value = base; slider.className = 'cooklang-slider';
    var out = el('span', 'cooklang-scale-val', String(base));
    ctrl.appendChild(slider); ctrl.appendChild(out);
    card.appendChild(ctrl);
    var ul = el('ul', 'cooklang-ing'); card.appendChild(ul);

    card.appendChild(el('h3', 'cooklang-h', 'Instructions'));
    var ol = el('ol', 'cooklang-steps'); card.appendChild(ol);

    var TOKEN = /@([^{]+)(?:\{([^%}]+)?(?:%([^}]+))?\})?|#([^{]+)(?:\{[^}]*\})?|~([^{]*)\{([^%]+)(?:%([^}]+))?\}/g;
    var lines = raw.split('\n').filter(function (l) { return l.trim().indexOf('>>') !== 0 && l.trim() !== ''; });

    function render(serv) {
      var mult = serv / base;
      ul.innerHTML = '';
      order.forEach(function (k) {
        var ing = uniq[k], li = document.createElement('li');
        var disp = ing.rawAmt;
        if (!isNaN(ing.amt)) disp = String(fmt(ing.amt * mult));
        var u = ing.unit ? (' ' + ing.unit) : '';
        if (disp) {
          var b = document.createElement('strong');
          b.textContent = disp + u;
          li.appendChild(b);
          li.appendChild(document.createTextNode(' ' + ing.name));
        } else { li.textContent = ing.name; }
        ul.appendChild(li);
      });
      ol.innerHTML = '';
      lines.forEach(function (line) {
        var li = document.createElement('li'), last = 0, mm;
        TOKEN.lastIndex = 0;
        while ((mm = TOKEN.exec(line)) !== null) {
          if (mm.index > last) li.appendChild(document.createTextNode(line.slice(last, mm.index)));
          if (mm[1] !== undefined) {
            var nm = mm[1].trim(), ds = nm;
            if (mm[2]) {
              var a = mm[2], pa = a.indexOf('/') > -1 ? frac(a) : parseFloat(a), fa = a.trim();
              if (!isNaN(pa)) fa = String(fmt(pa * mult));
              var fu = mm[3] ? (' ' + mm[3].trim()) : '';
              ds = fa + fu + ' ' + nm;
            }
            li.appendChild(el('span', 'cooklang-tok cooklang-tok-ing', ds));
          } else if (mm[4] !== undefined) {
            li.appendChild(el('span', 'cooklang-tok cooklang-tok-tool', mm[4].trim()));
          } else {
            var du = mm[7] ? (' ' + mm[7].trim()) : '';
            var act = (mm[5] && mm[5].trim()) ? (mm[5].trim() + ' for ') : '';
            li.appendChild(el('span', 'cooklang-tok cooklang-tok-time', act + mm[6] + du));
          }
          last = TOKEN.lastIndex;
          if (TOKEN.lastIndex === mm.index) TOKEN.lastIndex++;
        }
        if (last < line.length) li.appendChild(document.createTextNode(line.slice(last)));
        ol.appendChild(li);
      });
    }

    render(base);
    slider.addEventListener('input', function () {
      out.textContent = slider.value;
      render(parseFloat(slider.value));
    });
    return card;
  }
  function run() {
    var codes = document.querySelectorAll('pre > code');
    codes.forEach(function (code) {
      if (code.getAttribute('data-cooklang-done')) return;
      var lang = langOf(code);
      if (/dataviewjs|dataview/i.test(lang)) {
        code.setAttribute('data-cooklang-done', '1');
        var dpre = code.closest('pre');
        if (dpre) dpre.style.display = 'none';
        return;
      }
      if (!looksCook(code)) return;
      code.setAttribute('data-cooklang-done', '1');
      var pre = code.closest('pre');
      try {
        var w = build(rawText(code));
        if (pre) { pre.style.display = 'none'; pre.insertAdjacentElement('afterend', w); }
      } catch (e) {}
    });
  }
  document.addEventListener('nav', run);
  if (document.readyState !== 'loading') run();
})();
`;
var Cooklang = () => null;
Cooklang.css = `
.cooklang-card {
  border: 1px solid var(--lightgray);
  border-radius: 8px;
  padding: 1rem 1.25rem;
  margin: 1.5rem 0;
}
.cooklang-h { margin: 0.75rem 0 0.5rem; font-size: 1.05rem; }
.cooklang-h:first-child { margin-top: 0; }
.cooklang-scale {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 0.5rem 0 0.75rem;
  border-bottom: 1px solid var(--lightgray);
  margin-bottom: 0.75rem;
}
.cooklang-scale-label { font-weight: 600; }
.cooklang-slider { flex: 1; cursor: pointer; accent-color: var(--secondary); }
.cooklang-scale-val {
  font-weight: 700;
  color: var(--secondary);
  min-width: 1.5rem;
  text-align: right;
}
.cooklang-ing { margin: 0; padding-left: 1.25rem; line-height: 1.7; }
.cooklang-steps { margin: 0; padding-left: 1.25rem; line-height: 1.9; }
.cooklang-steps li { margin-bottom: 0.6rem; }
.cooklang-tok { padding: 1px 5px; border-radius: 4px; font-weight: 600; }
.cooklang-tok-ing { background: var(--highlight); color: var(--secondary); }
.cooklang-tok-tool { color: var(--tertiary); }
.cooklang-tok-time { color: var(--secondary); }
`;
Cooklang.afterDOMLoaded = SCRIPT;
var Cooklang_default = (() => Cooklang);
export {
  Cooklang_default as Cooklang
};
