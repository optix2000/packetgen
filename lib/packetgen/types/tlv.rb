module PacketGen
  module Types

    # Class to handle Type-Length-Value attributes
    # @author Sylvain Daubert
    class TLV < Fields
      # @!attribute type
      #  @return [Integer]
      define_field :type, Int8
      # @!attribute length
      #  @return [Integer]
      define_field :length, Int8
      # @!attribute value
      #  @return [String]
      define_field :value, String,
                   builder: ->(tlv) { String.new('', length_from: tlv[:length]) }

      # @param [Hash] options
      # @option options [Integer] :type
      # @option options [Integer] :length
      # @option options [String] :value
      # @option options [Class] :t {Int} subclass for +:type+ attribute.
      #   Default: {Int8}.
      # @option options [Class] :l {Int} subclass for +:length+ attribute.
      #   Default: {Int8}.
      def initialize(options={})
        super
        self[:type] = options[:t].new(type) if options[:t]
        if options[:l]
          self[:length] = options[:l].new(length)
          self[:value] = String.new('', length_from: self[:length])
        end
      end

        # @return [String]
        def to_human
          "type=#{type},len=#{length},value=#{value.inspect}"
        end
    end
  end
end