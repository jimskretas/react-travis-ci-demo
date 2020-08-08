#!/bin/bash

set -e # exit with nonzero exit code if anything fails

#copy data we're interested in to other place
cp -R /build $HOME/build

#go to home and setup git
cd $HOME
git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis"

#using token clone gh-pages branch
git clone --quiet --branch=gh-pages https://${github_token}@github.com/${GH_USER}/${GH_REPO}.git gh-pages > /dev/null

echo "Im at line 16\n"

#go into directory and copy data we're interested in to that directory
cd gh-pages
cp -Rf $HOME/build/* .

echo "Im at line 22\n"

#add, commit and push files
git add -f .
git commit -m "Travis build $TRAVIS_BUILD_NUMBER"
git push -fq origin gh-pages > /dev/null

echo "Done updating gh-pages\n"
