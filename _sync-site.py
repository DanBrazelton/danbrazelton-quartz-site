#!/usr/bin/env python3
"""Mirror publishable vault pages into the Quartz content folder.

Replaces quartz-syncer. Copies every `publish: true` .md from the vault's
Websites/danbrazelton/ tree into this repo's content/, and deletes any
content/*.md that is no longer published, so content/ exactly matches the
vault's publishable set. Run by deploy.bat before the git push.
"""
import re
from pathlib import Path

VAULT_SITE = Path(r"C:\Users\dan\Documents\DanBrazeltonVault\Websites\danbrazelton")
CONTENT = Path(__file__).resolve().parent / "content"
FM = re.compile(r"^---\n(.*?)\n---", re.S)


def is_published(text):
    m = FM.match(text)
    return bool(m) and re.search(
        r"^\s*publish:\s*[\"']?true[\"']?\s*$", m.group(1), re.I | re.M
    ) is not None


def main():
    if not VAULT_SITE.exists():
        print("ERROR: vault site folder not found: " + str(VAULT_SITE))
        return
    CONTENT.mkdir(parents=True, exist_ok=True)

    desired = {}
    for p in VAULT_SITE.rglob("*.md"):
        try:
            text = p.read_text(encoding="utf-8")
        except OSError:
            continue
        if is_published(text):
            desired[p.relative_to(VAULT_SITE).as_posix()] = text

    removed = 0
    for f in list(CONTENT.rglob("*.md")):
        if f.relative_to(CONTENT).as_posix() not in desired:
            f.unlink()
            removed += 1

    for rel, text in desired.items():
        dst = CONTENT / rel
        dst.parent.mkdir(parents=True, exist_ok=True)
        dst.write_text(text, encoding="utf-8")

    for d in sorted((d for d in CONTENT.rglob("*") if d.is_dir()), reverse=True):
        try:
            next(d.iterdir())
        except StopIteration:
            d.rmdir()

    print("Mirrored " + str(len(desired)) + " page(s) into content/; removed " + str(removed) + " stale.")


if __name__ == "__main__":
    main()
