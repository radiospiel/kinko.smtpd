#!/usr/bin/env roundup
describe "tests STARTTLS connection requirements"

. testhelper.inc

swaks="swaks --server localhost --port 2525"
swaks="$swaks --auth LOGIN --auth-user me@example.com --auth-password good.password"
swaks="$swaks --to user@example.com"

it_processes_ok() {
  start_ssmtpd \
      --hostname ssmtpd.test.local \
      --ssl-key $PWD/fixtures/ssmtpd.test.local.priv  \
      --ssl-cert $PWD/fixtures/ssmtpd.test.local.pem  \
      --auth $(which true) \
      --process $PWD/fixtures/process.ok


  tools/wait_port 2525 1

  ! $swaks
  $swaks --tls --tls-protocol no_sslv2,no_sslv3
  ! $swaks --tls --tls-protocol sslv2
  ! $swaks --tls --tls-protocol sslv3
}
