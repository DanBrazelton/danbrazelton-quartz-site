@echo off
setlocal enabledelayedexpansion

echo Publishing recipes...
python "C:\Users\dan\Documents\DanBrazeltonVault\Cooking\_publish-recipes.py"
echo.

cd /d "C:\Users\dan\Documents\quartz"
echo Deploying from: %CD%
echo.

set "msg="
set /p "msg=Commit message: "
if "!msg!"=="" set "msg=Update site"
echo.

git add -A
git commit -m "!msg!"
git pull --rebase origin main
git push origin main

echo.
echo Done. Cloudflare builds from this push.
echo (Recipe content still needs a quartz-syncer run in Obsidian.)
pause
