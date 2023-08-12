#!/usr/bin/make -f
##
# A simple wrapper for common developer commands.
# Most common commands: [run, clean]
##

site/index.html: prebuild
	hugo --minify -d site

browse: site/index.html
	sensible-browser site/index.html

run: prebuild
	hugo server --disableFastRender

prebuild:
	python3 themes/aamod/prebuild.py

# Exclusively for template-demo
demotweaks:
	sed 's/draft: true/draft: false/' content/example-contact.md >content/contact.md
	cp data/example-meetings.yaml data/meetings.yaml
	cp example-prebuild.yaml prebuild.yaml
	cp example-config.yaml config.yaml
	cp static/example-CNAME static/CNAME

clean:
	# hugo
	$(RM) -r exampleSite/.hugo_build.lock exampleSite/site exampleSite/resources
	# prebuild
	find exampleSite/content/meetings ! -name '_index.md' -type f -exec rm {} +
	$(RM) exampleSite/static/meeting-schedule.tex exampleSite/static/meeting-schedule.pdf
	$(RM) exampleSite/meeting-schedule.aux exampleSite/meeting-schedule.log

.PHONY: browse prebuild demotweaks clean
