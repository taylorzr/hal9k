describe Hal9k::Flags do
  it 'string flag' do
    argv, flags = ['-s', 'some_string'], [Hal9k::String.new(short: :s, long: :some_flag)]

    result = described_class.parse(argv, flags)

    expect(result).to eql(arguments: [], flags: { some_flag: 'some_string' })
  end

  it 'string flag' do
    argv, flags = ['--some-flag', 'some_string'], [Hal9k::String.new(short: :s, long: :some_flag)]

    result = described_class.parse(argv, flags)

    expect(result).to eql(arguments: [], flags: { some_flag: 'some_string' })
  end

  it 'flag without provided value with default' do
    argv, flags = ['-v'], [Hal9k::Boolean.new(short: :v, long: :verbose, default: true)]

    result = described_class.parse(argv, flags)

    expect(result).to eql(arguments: [], flags: { verbose: true })
  end

  it 'flag with provided value same as default' do
    argv, flags = ['-v', 'true'], [Hal9k::Boolean.new(short: :v, long: :verbose, default: true)]

    result = described_class.parse(argv, flags)

    expect(result).to eql(arguments: [], flags: { verbose: true })
  end

  it 'flag with provided value different from default' do
    argv, flags = ['-v', 'false'], [Hal9k::Boolean.new(short: :v, long: :verbose, default: true)]

    result = described_class.parse(argv, flags)

    expect(result).to eql(arguments: [], flags: { verbose: false })
  end

  it 'flag without value without default' do
    argv, flags = ['-v'], [Hal9k::Boolean.new(short: :v, long: :verbose)]

    expect do
      described_class.parse(argv, flags)
    end.to raise_error(StandardError)
  end

  it 'flag and argument' do
    argv, flags = ['-v', 'true', 'taco'], [Hal9k::Boolean.new(short: :v, long: :verbose)]

    result = described_class.parse(argv, flags)

    expect(result).to eql(arguments: ['taco'], flags: { verbose: true })
  end

  it 'flag and argument' do
    argv, flags = ['-v', 'true', 'taco'], [Hal9k::Boolean.new(short: :v, long: :verbose)]

    result = described_class.parse(argv, flags)

    expect(result).to eql(arguments: ['taco'], flags: { verbose: true })
  end

  xit 'multiple consecutive short flags' do
    argv, flags = ['-ayb'], [
      Hal9k::Boolean.new(short: :a, long: :all, default: true),
      Hal9k::Boolean.new(short: :y, long: :your, default: true),
      Hal9k::Boolean.new(short: :b, long: :base, default: true),
    ]

    result = described_class.parse(argv, flags)

    expect(result).to eql(arguments: [], flags: { all: true, your: true, base: true })
  end

  it 'multiple flags' do
    argv, flags = ['-a', '-y', '-b'], [
      Hal9k::Boolean.new(short: :a, long: :all, default: true),
      Hal9k::Boolean.new(short: :y, long: :your, default: true),
      Hal9k::Boolean.new(short: :b, long: :base, default: true),
    ]

    result = described_class.parse(argv, flags)

    expect(result).to eql(arguments: [], flags: { all: true, your: true, base: true })
  end

  it 'multiples flags with values' do
    argv, flags = ['-a', 'false', '-y', 'true', '-b', 'false'], [
      Hal9k::Boolean.new(short: :a, long: :all, default: true),
      Hal9k::Boolean.new(short: :y, long: :your, default: true),
      Hal9k::Boolean.new(short: :b, long: :base, default: true),
    ]

    result = described_class.parse(argv, flags)

    expect(result).to eql(arguments: [], flags: { all: false, your: true, base: false })
  end

  it 'parse simple long flags' do
    argv, flags = ['--verbose'], [Hal9k::Boolean.new(short: :v, long: :verbose, default: true)]

    result = described_class.parse(argv, flags)

    expect(result).to eql(arguments: [], flags: { verbose: true })
  end
end
