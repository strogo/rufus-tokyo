
#
# Specifying rufus-tokyo
#
# Sun Feb  8 13:13:41 JST 2009
#

require File.dirname(__FILE__) + '/spec_base'

require 'rufus/tokyo/tyrant'


describe 'a missing Tokyo Tyrant' do

  it 'should raise an error' do

    should.raise(RuntimeError) {
      Rufus::Tokyo::Tyrant.new('tyrant.example.com', 44000)
    }
  end
end

describe 'a Toyko Tyrant' do

  before do
    @tserver = Thread.new { puts `ttserver -port 44000` }
  end
  after do
    @tserver.kill
  end

  it 'should open and close' do
    should.not.raise {
      t = Rufus::Tokyo::Tyrant.new('127.0.0.1', 44000)
      t.close
    }
  end
end

describe 'a Toyko Tyrant' do

  before do
    @tserver = Thread.new { `ttserver -port 44001` }
    @t = Rufus::Tokyo::Tyrant.new('127.0.0.1', 44001)
    @t.clear
  end
  after do
    @t.close
    @tserver.kill
  end

  it 'should get put value' do

    @t['alpha'] = 'bravo'
    @t['alpha'].should.equal('bravo')
  end

  it 'should count records' do

    @t.size.should.equal(0)
    3.times { |i| @t[i.to_s] = i.to_s }
    @t.size.should.equal(3)
  end

  it 'should iterate records' do

    3.times { |i| @t[i.to_s] = i.to_s }
    @t.values.should.equal(%w{ 0 1 2 })
  end
end

