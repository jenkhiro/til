#! env ruby

file_path = ARGV[0]
row_limit = ARGV[1]

def get_offset(file_path, row_limit)
  file = File.open(file_path)
  cr_counter = 0
  offset = 0
  until cr_counter > row_limit.to_i
    offset -= 1
    begin
      file.seek(offset, IO::SEEK_END)
    rescue
      file.seek(0, IO::SEEK_SET)
      break
    end
    cr_counter += 1 if file.read(1) == "\n"
  end
  file.close
  offset + 1
end

def get_tail(file_path, row_limit)
  offset = get_offset(file_path, row_limit)
  file = File.open(file_path)
  file.seek(offset, IO::SEEK_END)
  file.each_line do |line|
    puts line.chomp
  end
  file.close
end

get_tail(file_path, row_limit)
