#!/usr/bin/env roundup
describe "tests email en/decryption"

. testhelper.inc

#
# If receiver's pubkeys are missing the encryption fails.
#
it_starts_and_stops() {
  kinko.smtpd.configure 
  kinko daemon:start smtpd
  kinko daemon:wait smtpd
  
  wait_port 8025

  kinko daemon:stop smtpd
  ! wait_port 8025
}
