set -eu

#
# -- before and after ---------------------------------------------------------

before() {
  :
}

after() {
  :
}

#
# -- expect -------------------------------------------------------------------
#
# Examples:
#   expect "echo 1" <<<'1'
#   expect "cat cleartext.mail | mailaddresses" <<-EXPECTATION
#     from: kinko@open-lab.org
#     to: reflect@open-lab.org
#   EXPECTATION
expect() {
  bash -c "$1" > $scrub/expectation
  git diff --no-index -- - $scrub/expectation
}
