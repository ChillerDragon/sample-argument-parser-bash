#!/bin/bash

err() {
	printf '\n%s\n' "$1" 1>%2
}
log() {
	printf '\n%s\n' "$1"
}

# compare two strings and ensure they match or crash
#
# @param actual
# @param expected
# @param [comment]
assert_eq() {
	local actual="$1"
	local expected="$2"
	local comment="${3:-}"
	if [ "$actual" = "$expected" ]
	then
		printf '.'
		return
	fi

	err "Error: failed assert_eq $comment"

	local actual_file
	local expected_file
	if ! actual_file="$(mktemp /tmp/assert_eq_inv_got_XXXXXXXX)"
	then
		err "Error: mktemp failed in assert"
		exit 1
	fi
	if ! expected_file="$(mktemp /tmp/assert_eq_inv_want_XXXXXXXX)"
	then
		err "Error: mktemp failed in assert"
		exit 1
	fi
	printf '%s' "$actual" > "$actual_file"
	printf '%s' "$expected" > "$expected_file"
	git --no-pager diff --no-index "$actual_file" "$expected_file" || true
	err "      check the files your self at"
	err ""
	err "      $actual_file"
	err "      $expected_file"
	err ""
	exit 1
}


assert_eq "$(./argparser.sh foo bar baz)" "\
got positional argument: foo
got positional argument: bar
got positional argument: baz"

assert_eq "$(./argparser.sh -vfx 2>&1)" "\
got verbose flag
got force flag
error unknown flag x"

assert_eq "$(./argparser.sh -- -vfx 2>&1)" "\
got positional argument: -vfx"

assert_eq "$(./argparser.sh hello -o out.txt world 2>&1)" "\
got positional argument: hello
output: out.txt
got positional argument: world"

assert_eq "$(./argparser.sh -- -o out.txt 2>&1)" "\
got positional argument: -o
got positional argument: out.txt"

assert_eq "$(./argparser.sh -o out.txt 2>&1)" "\
output: out.txt"

assert_eq "$(./argparser.sh --output=foo.txt -vo test.txt 2>&1)" "\
output: foo.txt
got verbose flag
output: test.txt"

log "all tests passed"

