# !/bin/bash
script=$(readlink -f "$0")
script_name=$(basename "$script")

feature=$1

echo -----------------refresh master-----------------

git checkout master
git fetch origin
git merge origin/master

echo -----------------remove $feature created before-----------------
git branch -vv -a
if git branch -vv -a | grep "origin/$1"; then git push origin -D $feature; fi  
if git branch -vv -a | grep "$1"; then git branch -D $feature; fi

echo -----------------create branch  $feature-----------------
git checkout -b $feature master

echo 2020-05-12 01:35:27 > $feature.txt
git add $feature.txt
git commit -m "add $feature.txt"

echo ------------------------changes on master------------------------

git checkout master
echo 2020-05-12 01:35:27: after checkout $feature > master.txt
git add master.txt build.sh
git commit --author="others <others@hp.com>" -m "modify master"
git push 

echo ------------------------log------------------------
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

git lg -10  --all

