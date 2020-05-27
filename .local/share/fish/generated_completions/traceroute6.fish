# traceroute6
# Autogenerated from man page /usr/share/man/man1/traceroute6.db.1.gz
complete -c traceroute6 -l help --description 'Print help info and exit.'
complete -c traceroute6 -s 4 -s 6 --description 'Explicitly force IPv4 or IPv6 tracerouting.'
complete -c traceroute6 -s I -l icmp --description 'Use ICMP ECHO for probes.'
complete -c traceroute6 -s T -l tcp --description 'Use TCP SYN for probes.'
complete -c traceroute6 -s d -l debug --description 'Enable socket level debugging (when the Linux kernel supports it).'
complete -c traceroute6 -s F -l dont-fragment --description 'Do not fragment probe packets.'
complete -c traceroute6 -s f -l first --description 'Specifies with what TTL to start.  Defaults to 1.'
complete -c traceroute6 -s g -l gateway --description 'Tells traceroute to add an IP source routing option to the outgoing packet th…'
complete -c traceroute6 -s i -l interface --description 'Specifies the interface through which  traceroute should send packets.'
complete -c traceroute6 -s m -l max-hops --description 'Specifies the maximum number of hops (max time-to-live value)  traceroute wil…'
complete -c traceroute6 -s N -l sim-queries --description 'Specifies the number of probe packets sent out simultaneously.'
complete -c traceroute6 -s n --description 'Do not try to map IP addresses to host names when displaying them.'
complete -c traceroute6 -s p -l port --description 'For UDP tracing, specifies the destination port base  traceroute will use (th…'
complete -c traceroute6 -s t -l tos --description 'For IPv4, set the Type of Service (TOS) and Precedence value.'
complete -c traceroute6 -s l -l flowlabel --description 'Use specified flow_label for IPv6 packets.'
complete -c traceroute6 -s w -l wait --description 'Determines how long to wait for a response to a probe. br  .'
complete -c traceroute6 -s q -l queries --description 'Sets the number of probe packets per hop.  The default is 3.'
complete -c traceroute6 -s r --description 'Bypass the normal routing tables and send directly to a host on an attached n…'
complete -c traceroute6 -s s -l source --description 'Chooses an alternative source address.'
complete -c traceroute6 -s z -l sendwait --description 'Minimal time interval between probes (default 0).'
complete -c traceroute6 -s e -l extensions --description 'Show ICMP extensions (rfc4884).'
complete -c traceroute6 -s A -l as-path-lookups --description 'Perform AS path lookups in routing registries and print results directly afte…'
complete -c traceroute6 -s V -l version --description 'Print the version and exit. br .'
complete -c traceroute6 -l sport --description 'Chooses the source port to use.  Implies  -N1-w5 .'
complete -c traceroute6 -l fwmark --description 'Set the firewall mark for outgoing packets (since the Linux kernel 2. 6. 25).'
complete -c traceroute6 -s M -l module --description 'Use specified method for traceroute operations.'
complete -c traceroute6 -s O -l options --description 'Specifies some method-specific option.'
complete -c traceroute6 -s U -l udp --description 'Use UDP to particular destination port for tracerouting (instead of increasin…'
complete -c traceroute6 -o UL --description 'Use UDPLITE for tracerouting (default port is 53).'
complete -c traceroute6 -s D -l dccp --description 'Use DCCP Requests for probes.'
complete -c traceroute6 -s P -l protocol --description 'Use raw packet of specified protocol for tracerouting.'
complete -c traceroute6 -l mtu --description 'Discover MTU along the path being traced.  Implies  -F-N1 .'
complete -c traceroute6 -l back --description 'Print the number of backward hops when it seems different with the forward di…'

