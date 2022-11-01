#!/bin/bash

# Read command arguments and extract repolink, reponame and username
repolink=$1
readarray -d / -t strarr <<<"$repolink"
arraylen=`expr ${#strarr[*]} - 1`
usernameIndex=`expr ${arraylen} - 1`
reponame=${strarr[arraylen]}
username=${strarr[usernameIndex]}
readarray -d . -t repoparts <<<"$reponame"
reponame=${repoparts[0]}
echo "Welcome to lab automation"
echo "Running Tests, please wait..."

workingDir=$(pwd)
mkdir $username
cd $username

# handle when repository already exists
if [ -d $reponame ]; then
    rm -r -f $reponame
fi

git clone $repolink
#continue after checking repo existance

# Handle any cloning failure by retrying 5 times
if [ ! -d $reponame ]; then
    tries=0
    while [ $tries -lt 5 ]
    do
        git clone $repolink
        if [ ! -d $reponame ]; then
            tries=`expr $tries + 1`
            if [ $tries -eq 5]; then
                echo "Failed to clone the repository"
                exit
            fi
        fi
    done
fi
# Stop handling the clone failures
echo "Cloned"

cd $reponame

mkdir "spec"
cp ../../app_spec.rb spec/spec_app.rb

rspec --init

if [ -f Gemfile.lock ]; then
    rm Gemfile.lock
fi

if [ -f .rspec ]; then
    rm .rspec spec/spec_helper.rb
fi

if [ -f spec/spec_helper.rb ]; then
    rm spec/spec_helper.rb
fi

sleep 1
rspec --init
sleep 1
bundle install
sleep 1

#perform the tests
# echo "Running ruby tests"
rspec spec/spec_app.rb

#cleaning up
cd $workingDir
rm -r -f $username