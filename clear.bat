echo Please wait a moment...
rm -rf ../temp
cake build
mkdir ../temp
echo mkdir ../temp
cp -r ../coffee-snode/node_modules ../temp/node_modules
cp -r ../coffee-snode/public ../temp/public
cp -r ../coffee-snode/snode ../temp/snode
cp -r ../coffee-snode/views ../temp/views
cp ../coffee-snode/app.js ../temp/app.js
cp ../coffee-snode/package.json ../temp/package.json
cp ../coffee-snode/readme.md ../temp/readme.md
echo OK Now,Please switch to temp!
