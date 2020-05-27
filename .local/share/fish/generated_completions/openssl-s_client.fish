# openssl-s_client
# Autogenerated from man page /usr/share/man/man1/openssl-s_client.1ssl.gz
complete -c openssl-s_client -o help --description 'Print out a usage message.'
complete -c openssl-s_client -o connect --description 'This specifies the host and optional port to connect to.'
complete -c openssl-s_client -o proxy --description 'When used with the -connect flag, the program uses the host and port specifie…'
complete -c openssl-s_client -o unix --description 'Connect over the specified Unix-domain socket.'
complete -c openssl-s_client -s 4 --description 'Use IPv4 only.'
complete -c openssl-s_client -s 6 --description 'Use IPv6 only.'
complete -c openssl-s_client -o servername --description 'Set the \\s-1TLS SNI\\s0 (Server Name Indication) extension in the ClientHello …'
complete -c openssl-s_client -o cert --description 'The certificate to use, if one is requested by the server.'
complete -c openssl-s_client -o certform --description 'The certificate format to use: \\s-1DER\\s0 or \\s-1PEM.  PEM\\s0 is the default.'
complete -c openssl-s_client -o key --description 'The private key to use.'
complete -c openssl-s_client -o keyform --description 'The private format to use: \\s-1DER\\s0 or \\s-1PEM.  PEM\\s0 is the default.'
complete -c openssl-s_client -o pass --description 'the private key password source.'
complete -c openssl-s_client -o verify --description 'The verify depth to use.'
complete -c openssl-s_client -o verify_return_error --description 'Return verification errors instead of continuing.'
complete -c openssl-s_client -o CApath --description 'The directory to use for server certificate verification.'
complete -c openssl-s_client -o CAfile --description 'A file containing trusted certificates to use during server authentication an…'
complete -c openssl-s_client -o no-CAfile --description 'Do not load the trusted \\s-1CA\\s0 certificates from the default file location.'
complete -c openssl-s_client -o no-CApath --description 'Do not load the trusted \\s-1CA\\s0 certificates from the default directory loc…'
complete -c openssl-s_client -o dane_tlsa_domain --description 'Enable \\s-1RFC6698/RFC7671 DANE TLSA\\s0 authentication and specify the \\s-1TL…'
complete -c openssl-s_client -o dane_tlsa_rrdata --description 'Use one or more times to specify the \\s-1RRDATA\\s0 fields of the \\s-1DANE TLS…'
complete -c openssl-s_client -o dane_ee_no_namechecks --description 'This disables server name checks when authenticating via \\s-1DANE-EE\\s0\\|(3) …'
complete -c openssl-s_client -o attime -o check_ss_sig -o crl_check -o crl_check_all -o explicit_policy -o extended_crl -o ignore_critical -o inhibit_any -o inhibit_map -o no_alt_chains -o no_check_time -o partial_chain -o policy -o policy_check -o policy_print -o purpose -o suiteB_128 -o suiteB_128_only -o suiteB_192 -o trusted_first -o use_deltas -o auth_level -o verify_depth -o verify_email -o verify_hostname -o verify_ip -o verify_name -o x509_strict --description 'Set various certificate chain validation options.'
complete -c openssl-s_client -o reconnect --description 'reconnects to the same server 5 times using the same session \\s-1ID,\\s0 this …'
complete -c openssl-s_client -o showcerts --description 'display the whole server certificate chain: normally only the server certific…'
complete -c openssl-s_client -o prexit --description 'print session information when the program exits.'
complete -c openssl-s_client -o state --description 'prints out the \\s-1SSL\\s0 session states.'
complete -c openssl-s_client -o debug --description 'print extensive debugging information including a hex dump of all traffic.'
complete -c openssl-s_client -o msg --description 'show all protocol messages with hex dump.'
complete -c openssl-s_client -o trace --description 'show verbose trace output of protocol messages.'
complete -c openssl-s_client -o msgfile --description 'file to send output of -msg or -trace to, default standard output.'
complete -c openssl-s_client -o nbio_test --description 'tests non-blocking I/O.'
complete -c openssl-s_client -o nbio --description 'turns on non-blocking I/O.'
complete -c openssl-s_client -o crlf --description 'this option translated a line feed from the terminal into \\s-1CR+LF\\s0 as req…'
complete -c openssl-s_client -o ign_eof --description 'inhibit shutting down the connection when end of file is reached in the input.'
complete -c openssl-s_client -o quiet --description 'inhibit printing of session and certificate information.'
complete -c openssl-s_client -o no_ign_eof --description 'shut down the connection when end of file is reached in the input.'
complete -c openssl-s_client -o psk_identity --description 'Use the \\s-1PSK\\s0 identity identity when using a \\s-1PSK\\s0 cipher suite.'
complete -c openssl-s_client -o psk --description 'Use the \\s-1PSK\\s0 key key when using a \\s-1PSK\\s0 cipher suite.'
complete -c openssl-s_client -o ssl3 -o tls1 -o tls1_1 -o tls1_2 -o no_ssl3 -o no_tls1 -o no_tls1_1 -o no_tls1_2 --description 'These options require or disable the use of the specified \\s-1SSL\\s0 or \\s-1T…'
complete -c openssl-s_client -o dtls -o dtls1 -o dtls1_2 --description 'These options make s_client use \\s-1DTLS\\s0 protocols instead of \\s-1TLS.'
complete -c openssl-s_client -o fallback_scsv --description 'Send \\s-1TLS_FALLBACK_SCSV\\s0 in the ClientHello.'
complete -c openssl-s_client -o async --description 'switch on asynchronous mode.'
complete -c openssl-s_client -o split_send_frag --description 'The size used to split data for encrypt pipelines.'
complete -c openssl-s_client -o max_pipelines --description 'The maximum number of encrypt/decrypt pipelines to be used.'
complete -c openssl-s_client -o read_buf --description 'The default read buffer size to be used for connections.'
complete -c openssl-s_client -o bugs --description 'there are several known bug in \\s-1SSL\\s0 and \\s-1TLS\\s0 implementations.'
complete -c openssl-s_client -o comp --description 'Enables support for \\s-1SSL/TLS\\s0 compression.'
complete -c openssl-s_client -o no_comp --description 'Disables support for \\s-1SSL/TLS\\s0 compression.'
complete -c openssl-s_client -o brief --description 'only provide a brief summary of connection parameters instead of the normal v…'
complete -c openssl-s_client -o sigalgs --description 'Specifies the list of signature algorithms that are sent by the client.'
complete -c openssl-s_client -o curves --description 'Specifies the list of supported curves to be sent by the client.'
complete -c openssl-s_client -o cipher --description 'this allows the cipher list sent by the client to be modified.'
complete -c openssl-s_client -o starttls --description 'send the protocol-specific message(s) to switch to \\s-1TLS\\s0 for communicati…'
complete -c openssl-s_client -o xmpphost --description 'This option, when used with \\*(L"-starttls xmpp\\*(R" or \\*(L"-starttls xmpp-s…'
complete -c openssl-s_client -o tlsextdebug --description 'print out a hex dump of any \\s-1TLS\\s0 extensions received from the server.'
complete -c openssl-s_client -o no_ticket --description 'disable RFC4507bis session ticket support.'
complete -c openssl-s_client -o sess_out --description 'output \\s-1SSL\\s0 session to filename.'
complete -c openssl-s_client -o sess_in --description 'load \\s-1SSL\\s0 session from filename.'
complete -c openssl-s_client -o engine --description 'specifying an engine (by its unique id string) will cause s_client to attempt…'
complete -c openssl-s_client -o rand --description 'a file or files containing random data used to seed the random number generat…'
complete -c openssl-s_client -o serverinfo --description 'a list of comma-separated \\s-1TLS\\s0 Extension Types (numbers between 0 and 6…'
complete -c openssl-s_client -o status --description 'sends a certificate status request to the server (\\s-1OCSP\\s0 stapling).'
complete -c openssl-s_client -o alpn -o nextprotoneg --description 'these flags enable the  Enable the Application-Layer Protocol Negotiation or …'
complete -c openssl-s_client -o ct --description 'Use one of these two options to control whether Certificate Transparency (\\s-…'

