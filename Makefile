.PHONY: install build serve check clean

# The github-pages gem's default theme SCSS needs a UTF-8 locale to compile.
export LC_ALL ?= C.UTF-8
export LANG ?= C.UTF-8

install:
	bundle install

build:
	bundle exec jekyll build --strict_front_matter

serve:
	bundle exec jekyll serve --livereload --strict_front_matter

# Validates internal links, images and alt text in the generated site.
# External links are intentionally not checked here (see ci.yml for the scheduled job).
check: build
	bundle exec htmlproofer ./_site \
		--disable-external \
		--allow-hash-href \
		--ignore-urls "/^mailto:/" \
		--no-enforce-https

clean:
	rm -rf _site .jekyll-cache
