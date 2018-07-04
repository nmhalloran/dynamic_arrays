require_relative "static_array"
require 'byebug'
require 'pry'

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @st_idx = 0
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index.abs >= length
    @store[(index + @st_idx) % @capacity]
  end

  # O(1)
  def []=(index, val)
    @store[(index + @st_idx) % @capacity] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    val = self[(@length - 1)]
    self[(@length - 1)] = nil
    @length = @length - 1
    val
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @store[(@st_idx + @length) % @capacity] = val
    @length = @length + 1
    @store

  end

  # O(1)
  def shift
    raise "index out of bounds" if @length == 0
    val = @store[@st_idx]
    @store[@st_idx] = nil
    @length = @length - 1
    @st_idx = (@st_idx + 1) % @capacity
    val
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @st_idx = @st_idx - 1
    self[0] = val
    @length = @length + 1
    @store
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    dup = @store
    @capacity = @capacity * 2
    @store = StaticArray.new(@capacity)
    @length.times do |idx|
      @store[(idx + @st_idx) % @capacity] = dup[(@st_idx + idx) % (@capacity / 2)]
    end
    @store
  end
end
