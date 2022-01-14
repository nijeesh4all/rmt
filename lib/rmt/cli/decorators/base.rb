require 'csv'
require 'terminal-table'

class RMT::CLI::Decorators::Base

  def to_csv
    raise NotImplementedError
  end

  def to_table
    raise NotImplementedError
  end

  protected

  def headers_to_csv(headers)
    CSV.generate { |csv| csv << headers }
  end

  def array_to_csv(array, headers, batch: nil)
    array.unshift(headers) unless batch
    CSV.generate { |csv| array.each { |row| csv << row } }
  end

  def array_to_table(data, headers)
    Terminal::Table.new headings: headers, rows: data
  end

end
