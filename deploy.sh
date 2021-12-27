#!/bin/bash
set -e

hexo clean
hexo generate
hexo deploy
