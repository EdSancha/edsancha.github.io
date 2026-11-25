.PHONY: install build serve check clean

# Jekyll needs a UTF-8 locale to read non-ASCII content reliably.
export LC_ALL ?= C.UTF-8
export LANG ?= C.UTF-8

# macOS ships Ruby 2.6, too old for this Gemfile. Use Homebrew's Ruby
# (brew install ruby) when it is installed; elsewhere (CI, Linux) the Ruby
# already on PATH is used, so nothing changes there.
# RUBY and BUNDLE are full paths because macOS's make (3.81) looks up simple
# commands on its original PATH; the exported PATH is for what they start.
HOMEBREW_RUBY := $(firstword $(wildcard /opt/homebrew/opt/ruby/bin /usr/local/opt/ruby/bin))
ifneq ($(HOMEBREW_RUBY),)
export PATH := $(HOMEBREW_RUBY):$(PATH)
RUBY := $(HOMEBREW_RUBY)/ruby
BUNDLE := $(HOMEBREW_RUBY)/bundle
else
RUBY := ruby
BUNDLE := bundle
endif

install:
	@$(RUBY) -e 'exit Gem::Version.new(RUBY_VERSION) >= Gem::Version.new("3.0")' || \
		{ echo "Ruby $$($(RUBY) -e 'print RUBY_VERSION') is too old for this site. On macOS: brew install ruby"; exit 1; }
	$(BUNDLE) config set --local path vendor/bundle
	$(BUNDLE) install

build:
	$(BUNDLE) exec jekyll build --strict_front_matter

serve:
	$(BUNDLE) exec jekyll serve --livereload --strict_front_matter

# Validates internal links, images and alt text in the generated site.
# External links are intentionally not checked here (see ci.yml for the scheduled job).
check: build
	$(BUNDLE) exec htmlproofer ./_site \
		--disable-external \
		--allow-hash-href \
		--ignore-urls "/^mailto:/" \
		--no-enforce-https

clean:
	rm -rf _site .jekyll-cache
