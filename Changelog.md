# Changelog

## Packetgen 3.1.4

* Add this Changelog.
* Make some little spped improvement on Headerable#read, Packet#add, Packet#insert and PcapNG::File#array_to_file.
* Clean up PcapNG module and Packet class.
* Drop Ruby 2.3 support on travis CI.
* Clean up gemspec.
* Types::AbstractTLV: add header_in_length flag. If set to true, then length in computed not only on value field but also on type and length ones.
* Inspect module: add some helper methods.
* Add Header::Eth::MacAddr#==, Header::IP:Addr#== and Header::IPv6:Addr#==.
* Isolate dependency on PCAPRUB into PCAPRUBWrapper module.
* Add Inject module to factorize code to inject data on wire.
* Move pcap-read logic into new Pcap module.
* Refactor Packet#decapsulate
* Add BindingError exception. This one replaces ArgumentError when no binding is found between two headers.