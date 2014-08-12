#!/usr/bin/env roundup
describe "tests SMTP authentication"

. testhelper.inc

it_supports_authentication() {
  start_ssmtpd \
      --hostname ssmtpd.test.local \
      --ssl-key $PWD/fixtures/ssmtpd.test.local.priv  \
      --ssl-cert $PWD/fixtures/ssmtpd.test.local.pem \
      --port 2626
  tools/wait_port 2626 1

  # don't accept non-authenticated mails
  ! swaks --to user@example.com \
    --server localhost \
    --port 2626 \
    --quit-after FROM
}
