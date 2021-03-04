#!/bin/bash

docker run -d --volume="$PWD:/srv/jekyll" -p=4000:4000 --name=my_blog jekyll/jekyll jekyll serve
