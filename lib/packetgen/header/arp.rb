# This file is part of PacketGen
# See https://github.com/sdaubert/packetgen for more informations
# Copyright (C) 2016 Sylvain Daubert <sylvain.daubert@laposte.net>
# This program is published under MIT license.

module PacketGen
  module Header

    # An ARP header consists of:
    # * a hardware type ({#hrd} or {#htype}) field ({Int16}),
    # * a protocol type ({#pro} or {#ptype}) field (+Int16+),
    # * a hardware address length ({#hln} or {#hlen}) field ({Int8}),
    # * a protocol address length ({#pln} or {#plen}) field (+Int8+),
    # * a {#opcode} (or {#op}) field (+Int16+),
    # * a source hardware address ({#sha} or {#src_mac}) field ({Eth::MacAddr}),
    # * a source protocol address ({#spa} or {#src_ip}) field ({IP::Addr}),
    # * a target hardware address ({#tha} or {#dst_mac}) field (+Eth::MacAddr+),
    # * a target protocol address ({#tpa} or {#dst_ip}) field (+IP::Addr+),
    # * and a {#body}.
    #
    # == Create a ARP header
    #  # standalone
    #  arp = PacketGen::Header::ARP.new
    #  # in a packet
    #  pkt = PacketGen.gen('Eth').add('ARP')
    #  # access to ARP header
    #  pkt.arp   # => PacketGen::Header::ARP
    #
    # @author Sylvain Daubert
    class ARP < Base

      define_field :hrd, StructFu::Int16, default: 1
      define_field :pro, StructFu::Int16, default: 0x800
      define_field :hln, StructFu::Int8, default: 6
      define_field :pln, StructFu::Int8, default: 4
      define_field :op, StructFu::Int16, default: 1
      define_field :sha, Eth::MacAddr
      define_field :spa, IP::Addr
      define_field :tha, Eth::MacAddr
      define_field :tpa, IP::Addr
      # @!attribute body
      #  @return [StructFu::String,Header::Base]
      define_field :body, StructFu::String

      # @param [Hash] options
      # @option options [Integer] :hrd network protocol type (default: 1)
      # @option options [Integer] :pro internet protocol type (default: 0x800)
      # @option options [Integer] :hln length of hardware addresses (default: 6)
      # @option options [Integer] :pln length of internet addresses (default: 4)
      # @option options [Integer] :op operation performing by sender (default: 1).
      #   known values are +request+ (1) and +reply+ (2)
      # @option options [String] :sha sender hardware address
      # @option options [String] :spa sender internet address
      # @option options [String] :tha target hardware address
      # @option options [String] :tpa targetr internet address
      def initialize(options={})
        options[:hrd] ||= options[:htype] 
        options[:pro] ||= options[:ptype] 
        options[:hln] ||= options[:hlen] 
        options[:pln] ||= options[:plen] 
        options[:op]  ||= options[:opcode] 
        options[:sha] ||= options[:src_mac] 
        options[:spa] ||= options[:src_ip] 
        options[:tha] ||= options[:dst_mac] 
        options[:tpa] ||= options[:dst_ip]
        super 
      end

      alias :htype :hrd
      alias :htype= :hrd=
      alias :ptype :pro
      alias :ptype= :pro=
      alias :hlen :hln
      alias :hlen= :hln=
      alias :plen :pln
      alias :plen= :pln=
      alias :opcode :op
      alias :opcode= :op=
      alias :src_mac :sha
      alias :src_mac= :sha=
      alias :src_ip :spa
      alias :src_ip= :spa=
      alias :dst_mac :tha
      alias :dst_mac= :tha=
      alias :dst_ip :tpa
      alias :dst_ip= :tpa=
    end

    self.add_class ARP

    Eth.bind_header ARP, ethertype: 0x806
  end
end

