#!/usr/bin/env roundup
describe "tests SMTP authentication"

. testhelper.inc

swaks="swaks --server localhost --port 2525 --tls --tls-protocol no_sslv2,no_sslv3"

it_processes_ok() {
  start_ssmtpd \
      --hostname ssmtpd.test.local \
      --ssl-key $PWD/fixtures/ssmtpd.test.local.priv  \
      --ssl-cert $PWD/fixtures/ssmtpd.test.local.pem  \
      --auth $(which true) \
      --process $PWD/fixtures/process.ok

  tools/wait_port 2525 1

  $swaks --to user@example.com \
    --auth LOGIN \
    --auth-user me@example.com \
    --auth-password good.password
}

it_processes_fail() {
  start_ssmtpd \
      --hostname ssmtpd.test.local \
      --ssl-key $PWD/fixtures/ssmtpd.test.local.priv  \
      --ssl-cert $PWD/fixtures/ssmtpd.test.local.pem  \
      --auth $(which true) \
      --process $PWD/fixtures/process.ok

  tools/wait_port 2525 1

  $swaks --to user@example.com \
    --auth LOGIN \
    --auth-user me@example.com \
    --auth-password good.password
}
