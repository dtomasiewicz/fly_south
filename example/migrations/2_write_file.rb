module FlySouth::Migrations

  def write_file_up
  	File.open('example.txt', 'w'){|f| f.write "hello\n"}
  end

  def write_file_down
  	File.truncate 'example.txt', 0
  end

end