echo Please wait a moment...
rm -rf ../temp
cake build
cp -r ../coffee-snode ../temp
cd ../temp
rm -rf snode_server
rm -rf .git
rm -rf .idea
rm .gitignore
rm Cakefile
rm .travis.yml
rm build.bat
rm clear.bat
rm strat.bat
rm togitcafe.bat
echo OK Now!
