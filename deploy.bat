@echo off
setlocal

echo === Building Jekyll site ===
cmd /c "bundle exec jekyll build"

echo === Preparing temporary deploy folder ===
rmdir /s /q ..\gh-pages-tmp 2>nul
mkdir ..\gh-pages-tmp

echo === Copying _site to temp folder ===
xcopy /E /Y /I _site\* ..\gh-pages-tmp

cd ..\gh-pages-tmp

echo === Initializing Git and pushing to gh-pages ===
git init
git remote remove origin 2>nul
git remote add origin https://github.com/PoulBold/publishing-expert.git
git checkout -b gh-pages
git add .
git commit -m "deploy: update site"
git push -f origin gh-pages

echo === DONE! Your site is live at ===
echo https://poulbold.github.io/publishing-expert/

endlocal
pause
