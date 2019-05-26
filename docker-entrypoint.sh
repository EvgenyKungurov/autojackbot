#!/bin/sh

bundle exec hanami server && nginx -g 'daemon off;'