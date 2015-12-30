SHELL := /bin/bash
ifiles = $(wildcard contents/*)
version := $(shell (git describe --tags 2> /dev/null || git show --oneline -s || echo dev) | cut -f1 -d' ' )
date := $(shell date +%Y-%m-%d --date @$$(git show -s --format=%ct || date +%s))
outdir = build/rundeck-local-script-$(version)-plugin
ofiles = $(ifiles:%=$(outdir)/%)
outfile = build/rundeck-local-script-$(version)-plugin.zip

all: $(outdir) $(outdir)/contents $(outfile)

$(outfile): $(outdir)/plugin.yaml $(ofiles)
	cd build && zip -r $(@:build/%=%) $(^:build/%=%)

$(outdir):
	mkdir -p $@

$(outdir)/contents:
	mkdir -p $@

$(outdir)/plugin.yaml:
	cp plugin.yaml $@
	sed -i $@ -e 's/%%VERSION%%/$(version)/g' -e 's/%%DATE%%/$(date)/g'

$(outdir)/contents/%: contents/%
	cp $< $@

clean:
	rm -rf $(outdir) $(outfile)

distclean:
	rm -rf build

.PHONY: all build clean distclean
