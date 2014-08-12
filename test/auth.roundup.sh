#!/usr/bin/env roundup
describe "tests SMTP authentication"

. testhelper.inc

swaks="swaks --server localhost --port 2525 --tls --tls-protocol no_sslv2,no_sslv3"

it_requires_authentication() {
  start_ssmtpd \
      --hostname ssmtpd.test.local \
      --ssl-key $PWD/fixtures/ssmtpd.test.local.priv  \
      --ssl-cert $PWD/fixtures/ssmtpd.test.local.pem 
  tools/wait_port 2525 1

  # don't accept non-authenticated mails
  ! $swaks --to user@example.com \
    --quit-after FROM
}

it_authenticates() {
  start_ssmtpd \
      --hostname ssmtpd.test.local \
      --ssl-key $PWD/fixtures/ssmtpd.test.local.priv  \
      --ssl-cert $PWD/fixtures/ssmtpd.test.local.pem  \
      --auth $(which true)
   
  tools/wait_port 2525 1

  # supports LOGIN
  $swaks --to user@example.com \
    --auth LOGIN \
    --auth-user me@example.com \
    --auth-password good.password

  # supports PLAIN
  $swaks --to user@example.com \
    --auth PLAIN \
    --auth-user me@example.com \
    --auth-password good.password
}

it_authenticates_via_false_process() {
  start_ssmtpd \
      --hostname ssmtpd.test.local \
      --ssl-key $PWD/fixtures/ssmtpd.test.local.priv  \
      --ssl-cert $PWD/fixtures/ssmtpd.test.local.pem  \
      --auth $(which false)
   
  tools/wait_port 2525 1

  # supports LOGIN
  ! $swaks --to user@example.com \
    --auth LOGIN \
    --auth-user me@example.com \
    --auth-password good.password

  # supports PLAIN
  ! $swaks --to user@example.com \
    --auth PLAIN \
    --auth-user me@example.com \
    --auth-password good.password
}

it_authenticates_via_real_process() {
  start_ssmtpd \
      --hostname ssmtpd.test.local \
      --ssl-key $PWD/fixtures/ssmtpd.test.local.priv  \
      --ssl-cert $PWD/fixtures/ssmtpd.test.local.pem  \
      --auth $PWD/fixtures/authenticate

  tools/wait_port 2525 1

  # supports LOGIN
  $swaks --to user@example.com \
    --auth LOGIN \
    --auth-user me@example.com \
    --auth-password good.password

  # supports PLAIN
  $swaks --to user@example.com \
    --auth PLAIN \
    --auth-user me@example.com \
    --auth-password good.password
}
