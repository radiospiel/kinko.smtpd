# ssmtpd - a super simple SMTP server.

ssmtpd is a light weight and simple SMTP server, which implements only
the receiving side. Authentication and email processing is handled by
external applications.

ssmtpd implements STARTTLS sessions and LOGIN and PLAIN authentication. 
It usually only accepts incoming mail that are submitted via STARTTLS and are
authenticated.

## License

The ssmtpd project is released under a MIT-style open source license. See the 
file LICENSE for details.

The ssmtpd project is based on Go-Guerrilla SMTPd Version 1.1, but heavily
modified towards the needs of the kinko.me email crypto package. 

## kinko.me usage

This package was started as the kinko.me smtpd source package. That's why
there is a Manifest file and a number of files in ./bin.

For more information on kinko.me see http://kinko.me

## Stand-alone usage

You can use `ssmtpd` outside of the scope of the kinko.me project. For this ignore
everything in the ./bin directory and run `bin/ssmtpd`.

	exec bin/ssmtpd                              \
		--hostname      my.host.name             \
		--port 8025                              \
		--ssl-key       path/to/ssl.key          \
		--ssl-cert      path/to/ssl.key          \
		--auth          path/to/auth             \
		--process       path/to/process

The above command uses `path/to/auth` to authenticate logins, and `path/to/process` to
process emails.

### Authentication

Authentication is done in an external process. The process itself is set via the `--auth`
argument. It receives username and password to verify via the SSMTPD_USERNAME and SSMTPD_PASSWORD
environment settings, and must exit successfully (exitcode 0) on success.

### Processing

Email processing is done in an external process. The process itself is set via the `--process`
argument. This process will receive the authenticated user name as the first and single argument,
and the email data via STDIN.

The process must exit w/exitcode 0 on success.

## Differences to other SMTP servers

Note that ssmtpd was built for usage with the kinko.me project. That's why 
this server does things different:

- it is not designed for high throughput installations (but still performs pretty well, as in
  10 msecs per email on a local installation)
- emails are processed synchronously: only after the `--process` process is finished success
  will be signaled to the client.
- "MAIL FROM:" and "RCPT TO:" will be ignored. They don't make sense in the kinko.me project,
  where emails are basically passed along, and sender and recipients from the email itself
  should take precedence over whatever will be passed on here.
  
