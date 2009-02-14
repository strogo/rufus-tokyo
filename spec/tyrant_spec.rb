
#
# Specifying rufus-tokyo
#
# Sun Feb  8 13:13:41 JST 2009
#

require File.dirname(__FILE__) + '/spec_base'

describe 'a missing Tokyo Tyrant' do

  it 'should raise an error' do

    should.raise(RuntimeError) {
      Tyrant.new('tyrant.example.com', 45000)
    }
  end
end

describe 'a Toyko Tyrant' do

  it 'should open and close' do
    should.not.raise {
      t = Tyrant.new('127.0.0.1', 45000)
      t.close
    }
  end
end

describe 'a Toyko Tyrant' do

  before do
    @t = Tyrant.new('127.0.0.1', 45000)
    @t.clear
  end
  after do
    @t.close
  end

  it 'should get put value' do

    @t['alpha'] = 'bravo'
    @t['alpha'].should.equal('bravo')
  end

  it 'should count entries' do

    @t.size.should.equal(0)
    3.times { |i| @t[i.to_s] = i.to_s }
    @t.size.should.equal(3)
  end

  it 'should delete entries' do

    @t['alpha'] = 'bravo'
    @t.delete('alpha').should.equal('bravo')
    @t.size.should.equal(0)
  end

  it 'should iterate entries' do

    3.times { |i| @t[i.to_s] = i.to_s }
    @t.values.should.equal(%w{ 0 1 2 })
  end
end
