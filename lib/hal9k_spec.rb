describe Hal9k do
  describe '.translate' do
    it 'translates command line arguments to a command' do
      class Echo < Hal9k::Command
        # See virtus for type handling
        # How can we safely get Boolean instead of Hal9k::Boolean
        # or just use symbols? yea prolly
        # and also support custom classes
        flag :new_line, :n, type: Hal9k::Boolean, default: true

        def call
          string = arguments.join(' ')
          string += "\n" if flags[:new_line]
          string
        end
      end

      result = described_class.translate(['-n', 'Hello', 'World!'])

      expect(result).to be_an(Echo)
    end
  end
end

