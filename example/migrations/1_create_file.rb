module FlySouth::Migrations

  def create_file_up
    File.open('example.txt', 'w'){}
  end

  def create_file_down
    File.delete 'example.txt'
  end

end