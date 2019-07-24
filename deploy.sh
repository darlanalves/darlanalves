hexo clean
hexo generate
cp CNAME public/
cd public
git init
git remote add origin git@github.com:darlanalves/darlanalves.github.io.git
git add .
git commit -m "chore: update site content"
git push origin master -f
cd -
