# ssmtpd - a super simple SMTP server.

ssmtpd is a light weight and simple SMTP server, which implements only
the receiving side. Authentication and email processing is handled by
external applications.

ssmtpd implements STARTTLS sessions and LOGIN and PLAIN authentication. 
It only accepts incoming mail that are submitted via STARTTLS and are
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

You can use `ssmtpd` without the entire kinko.me package. For this ignore
everything in the ./bin directory and run `lib/ssmtpd`.

	exec $ssmtpd                                 \
		--hostname      my.host.name             \
		--port 8025                              \
		--ssl-key       path/to/ssl.key          \
		--ssl-cert      path/to/ssl.cert         \
		--accounts-db   var/accounts.sqlite3     \
		--filter        kinko.mailqueue.forward
 
