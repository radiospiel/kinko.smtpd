#!/usr/bin/env roundup
describe "tests email en/decryption"

. testhelper.inc

it_listens_on_2525_by_default() {
  start_ssmtpd \
      --hostname ssmtpd.test.local \
      --ssl-key $PWD/fixtures/ssmtpd.test.local.priv  \
      --ssl-cert $PWD/fixtures/ssmtpd.test.local.pem 
  tools/wait_port 2525 1

  stop_ssmtpd
  ! tools/wait_port 2525
}

it_listens_on_custom_port() {
  start_ssmtpd \
      --hostname ssmtpd.test.local \
      --ssl-key $PWD/fixtures/ssmtpd.test.local.priv  \
      --ssl-cert $PWD/fixtures/ssmtpd.test.local.pem  \
      --port 2626 
  tools/wait_port 2626 1
  ! tools/wait_port 2525

  stop_ssmtpd
  ! tools/wait_port 2626
  ! tools/wait_port 2525
}
