git clone https://github.com/gitlantis/ExadelTask01.git
cd ExadelTask01
mkdir Task1
cd Task1
echo "hello world">test.txt
cd ..
git add .
git commit -m "initial commit"
git push -u origin master

git branch dev
git branch asliddin-new_feature
git checkout asliddin-new_feature
echo # readme file > README.md
git status
touch .gitignore
git add .
git commit -m "gitignore and readme added"
git push --all

# created pull rquest for asliddin-new_feature -> dev via github interface
# merged asliddin-new_feature -> dev

# created pull rquest for dev -> master via github interface
# merged dev -> master

git add .
git commit -m 'readme modified'
git reset --hard HEAD~1

git checkout master
git log > log.txt

git branch -D asliddin-new_feature
git push origin --delete asliddin-new_feature

git checkout dev
touch git_commands.md
