require './init.rb'
require 'benchmark'

puts Benchmark.measure {
  5.times{
    rent = Airbnb::RentInfo.find(location: "倫敦")
  }
}.real

puts Benchmark.measure {
  5.times{
    Concurrent::Promise.execute { Airbnb::RentInfo.find(location: "倫敦") }
  }
}.real
