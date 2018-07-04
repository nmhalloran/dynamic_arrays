require 'queue_with_max'

describe QueueWithMax do
  it "enqueues" do
    queue = QueueWithMax.new
    5.times do |i|
      queue.enqueue(i)
    end
    expect(queue.length).to eq(5)
  end

  it "dequeues" do
    q = QueueWithMax.new
    5.times do |i|
      q.enqueue(i)
    end
    5.times do
      q.dequeue
    end
    expect(q.length).to eq(0)
  end

  it 'returns the correct max while enqueuing' do
    q = QueueWithMax.new
    arr = [1,3,4,10,9]
    5.times do |i|
      max = arr[0..i].max
      q.enqueue(arr[i])
      expect(q.max).to eq(max)
    end
  end

  it 'returns the correct max while dequeuing' do
    queue = QueueWithMax.new
    arr = [1,3,4,10,9,3,2,17,5]
    arr.each { |el| queue.enqueue(el) }
    (1...arr.length).each do |idx|
      max = arr[idx..-1].max
      queue.dequeue
      expect(queue.max).to eq(max)
    end
  end

end
