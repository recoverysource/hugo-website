#!/usr/bin/make -f
##
# A simple wrapper for common developer commands.
# Most common commands: [run, clean]
##

public/index.html: gen_content
	hugo --minify -d site

browse: site/index.html
	sensible-browser site/index.html

run: gen_content
	hugo server --disableFastRender

gen_content:
	python3 ./themes/aamod/generate_content.py

clean:
	# hugo
	$(RM) -r .hugo_build.lock site resources
	# generate_content.py
	$(RM) content/meeting-zips.md content/meeting-times.md static/meeting-times.json
	find content/meetings ! -name '_index.md' -type f -exec rm {} +
	$(RM) static/meeting-schedule.tex static/meeting-schedule.pdf
	$(RM) meeting-schedule.aux meeting-schedule.log
	$(RM) data/geos.yaml

.PHONY: browse gen_content clean
