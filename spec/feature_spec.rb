describe 'Usage' do
  it 'echos input' do
    result = `examples/echo hi`

    expect(result).to eql("hi\n")
  end

  pending 'echos input without a newline' do
    result = `examples/echo hi -n`

    expect(result).to eql('hi')
  end

  context 'arguments' do
    it 'accepts any number of arguments' do
      result = `examples/math add 1 1`

      expect(result).to eql("2\n")

      result = `examples/math add 1 1 1 1 1 1`

      expect(result).to eql("6\n")
    end

    it 'accepts a single argument followed by any number of arguments' do
      result = `examples/math label_add '1 + 1 = ' 1 1`

      expect(result).to eql("1 + 1 = 2\n")

      result = `examples/math label_add '1 + 1 + 1 + 1 + 1 + 1 = ' 1 1 1 1 1 1`

      expect(result).to eql("1 + 1 + 1 + 1 + 1 + 1 = 6\n")
    end
  end

  context 'flags' do
    it 'flags cascade by default'
    it 'flags can be local'
  end
end
