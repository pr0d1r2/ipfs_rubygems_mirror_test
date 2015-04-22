#!/bin/bash

BASE_DIR="/tmp/rubygems_minimal_mirror"

for URI_PATH in \
  gems/activemodel-3.2.8.gem \
  gems/activerecord-3.2.8.gem \
  gems/activesupport-3.2.8.gem \
  gems/arel-3.0.3.gem \
  gems/builder-3.0.4.gem \
  gems/tzinfo-0.3.43.gem \
  quick/Marshal.4.8/activemodel-3.2.8.gemspec.rz \
  quick/Marshal.4.8/activerecord-3.2.8.gemspec.rz \
  quick/Marshal.4.8/activesupport-3.2.8.gemspec.rz \
  quick/Marshal.4.8/arel-3.0.3.gemspec.rz \
  quick/Marshal.4.8/builder-3.0.4.gemspec.rz \
  quick/Marshal.4.8/tzinfo-0.3.43.gemspec.rz \
  specs.4.8.gz
do
  DIR="$BASE_DIR/`dirname $URI_PATH`"
  FILE=`basename $URI_PATH`
  if [ ! -d $DIR ]; then
    mkdir -p $DIR
  fi
  if [ ! -f $DIR/$FILE ]; then
    curl https://rubygems.org/$URI_PATH -o $DIR/$FILE
  fi
done

if [ ! -d $BASE_DIR/api/v1 ]; then
  mkdir -p $BASE_DIR/api/v1
fi
touch $BASE_DIR/api/v1/dependencies

cd $BASE_DIR
ipfs add -r .

echo
echo "Put similar line with hash from top level directory (.) into your Gemfile:"
echo
echo "source 'http://127.0.0.1:8080/ipfs/QmZKxosxcTKLGQpcpVcES8dyg8Gxxv7ZPnrEk4Hm13eNh1'"
echo
