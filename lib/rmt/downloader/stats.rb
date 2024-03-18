class RMT::Downloader::Stats
  attr_reader :total_size, :files_count

  def initialize
    # ensure thread-safe access to the `@total_size` and `@files_count` counters.
    # Since the calling method for these counters could potentially run in multiple threads concurrently
    @total_size_mutex = Mutex.new
    @files_count_mutex = Mutex.new

    @total_size = 0
    @files_count = 0
  end

  def increment_files_count
    @files_count_mutex.synchronize do
      @files_count += 1
    end
  end

  def increment_total_size(bytes)
    @total_size_mutex.synchronize do
      @total_size += bytes
    end
  end

  def total_size_in_mb
    megabytes = total_size / 1_000_000.0
    megabytes.round(2)
  end

  def reset!
    @total_size = 0
    @files_count = 0
  end

  def to_h
    {
      files_count: files_count,
      total_size: total_size
    }
  end
end