require_relative "static_array"
require 'byebug'

class DynamicArray
  attr_reader :length

  def initialize
    @length = 0;
    @capacity = 8;
    @store = StaticArray.new(@capacity);
    @start_index = 0;
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if @length <= index
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    val = @store[@length - 1]
    @store[@length - 1] = nil
    @length = @length - 1
    val
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @store[@length] = val
    @length = @length + 1
    @store
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if @length == 0
    val = @store[0]
    @length.times do |idx|
      @store[idx] = @store[idx + 1]
    end
    @store[@length - 1] = nil
    @length = @length - 1
    val
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    dup = @store
    resize! if @length == @capacity
    @length.downto(1) do |idx|
      @store[idx] = dup[idx - 1]
    end
    @store[0] = val
    @length = @length + 1
    @store
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    dup = @store
    @capacity = @capacity * 2
    @store = StaticArray.new(@capacity)
    @length.times do |idx|
      @store[idx] = dup[idx]
    end
    @store
  end
end
