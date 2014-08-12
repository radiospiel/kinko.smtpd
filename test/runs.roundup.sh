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
