# !/bin/bash
feature=$1
export feature=$feature

echo -----------------refresh master-----------------

git checkout master
git fetch origin
git merge origin/master

echo -----------------remove $feature created before-----------------
git branch -vv -a
if git branch -vv -a | grep "origin/$feature"; then git push origin -D $feature; fi  
if git branch -vv -a | grep "$feature"; then git branch -D $feature; fi

echo -----------------create branch  $feature-----------------
git checkout -b $feature master

echo 2020-05-12 02:45:28 > $feature.txt
git add $feature.txt
git commit -m "add $feature.txt"
git push -u origin $feature 

echo ------------------------changes on master------------------------

git checkout master
echo 2020-05-12 02:45:28: after checkout $feature > master.txt
git add master.txt build.sh
git commit --author="others <others@hp.com>" -m "modify master"
git push 

echo ------------------------log------------------------
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

git lg -10  --all

