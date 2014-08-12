set -eu

#
# -- before and after ---------------------------------------------------------

function before() {
  :
}

function after() {
  stop_ssmtpd
}

# -- start and stop ssmtpd ----------------------------------------------------

function start_ssmtpd() {
  mkdir -p $PWD/pids

  $PWD/../bin/ssmtpd $@ &
  echo $! > ssmtpd.pid
}

function stop_ssmtpd() {
  if [ -f ssmtpd.pid ]; then
    kill $(cat ssmtpd.pid) || true
    rm -f ssmtpd.pid
  fi
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
