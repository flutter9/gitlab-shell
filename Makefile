.PHONY: validate verify verify_ruby verify_golang test test_ruby test_golang setup _install build compile check clean

GO_SOURCES := $(shell find go -name '*.go')

validate: verify test

verify: verify_ruby verify_golang

verify_ruby:
	bundle exec rubocop

verify_golang:
	support/go-format check

test: test_ruby test_golang

# The Ruby tests are now all integration specs that test the Go implementation.
test_ruby:
	bundle exec rspec --color --format d spec

test_golang:
	support/go-test

setup: _install bin/gitlab-shell

_install:
	bin/install

build: bin/gitlab-shell
compile: bin/gitlab-shell
bin/gitlab-shell: $(GO_SOURCES)
	bin/compile

check:
	bin/check

clean:
	rm -f bin/gitlab-shell bin/gitlab-shell-authorized-keys-check bin/gitlab-shell-authorized-principals-check
