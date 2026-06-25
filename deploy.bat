@echo off
setlocal enabledelayedexpansion

echo [1/5] Generating recipes...
python "C:\Users\dan\Documents\DanBrazeltonVault\Cooking\_publish-recipes.py"
echo.

cd /d "C:\Users\dan\Documents\quartz"

echo [2/5] Committing any pending code changes...
git add -A
git commit -m "Pre-deploy: pending changes" 1>nul 2>nul

echo [3/5] Pulling latest from remote...
git pull --rebase origin main

echo [4/5] Mirroring site content...
python "C:\Users\dan\Documents\quartz\_sync-site.py"
echo.

set "msg="
set /p "msg=Commit message: "
if "!msg!"=="" set "msg=Update site"

git add -A
git commit -m "!msg!" 1>nul 2>nul

echo [5/5] Pushing...
git push origin main

echo.
echo Done. Cloudflare builds from this push. Syncer no longer needed.
pause
